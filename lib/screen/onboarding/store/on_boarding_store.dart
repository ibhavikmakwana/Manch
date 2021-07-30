/*
 * BSD 2-Clause License
 *
 * Copyright (c) 2021, Bhavik Makwana
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_playground/models/user_profile.dart';
import 'package:supabase_playground/values/app_colors.dart';
import 'package:supabase_playground/values/extensions.dart';
import 'package:supabase_playground/values/routes.dart';

part 'on_boarding_store.g.dart';

class OnBoardingStore = _OnBoardingStore with _$OnBoardingStore;

abstract class _OnBoardingStore with Store {
  _OnBoardingStore() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
  }

  final GlobalKey<FormState> onBoardingFormKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;
  late final FocusNode confirmPasswordFocusNode;

  @observable
  bool isLogin = true;

  @observable
  bool isLoading = false;

  @action
  Future<void> signUp(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;
    if (!_validateEmailPassword()) return;

    isLoading = true;

    try {
      final response =
          await Supabase.instance.client.auth.signUp(email, password);
      if (response.error != null) {
        context.showSnackBar(
          response.error?.message ?? 'Something went wrong!',
          color: AppColors.red,
        );
        debugPrint(response.error?.message);
      } else {
        final doLogin = await createUserInDB(response.data?.user);
        if (doLogin) await login(context);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> createUserInDB(User? user) async {
    try {
      final requestBody = JsonMapper.toMap(
        UserProfile(id: user?.id, email: user?.email),
        const SerializationOptions(ignoreNullMembers: true),
      );

      final response = await Supabase.instance.client
          .from('profiles')
          .insert(requestBody)
          .execute();

      if (response.error != null) {
        debugPrint('Error: ${response.toJson()}');
        return false;
      } else {
        debugPrint('Success Response: ${response.toJson()}');
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> login(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;
    if (!_validateEmailPassword()) return;

    try {
      isLoading = true;
      final response = await Supabase.instance.client.auth.signIn(
        email: email,
        password: password,
      );
      if (response.error != null) {
        context.showSnackBar(
          response.error?.message ?? 'Something went wrong!',
          color: AppColors.red,
        );
        debugPrint(response.error?.message);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.dashboard,
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
    }
  }

  bool _validateEmailPassword() {
    return onBoardingFormKey.currentState?.validate() ?? false;
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
  }
}
