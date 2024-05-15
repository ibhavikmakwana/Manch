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
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:manch/core/supabase/build_config.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'on_boarding_store.g.dart';

class OnBoardingStore = _OnBoardingStore with _$OnBoardingStore;

abstract class _OnBoardingStore with Store {
  _OnBoardingStore() {
    emailController = TextEditingController(text: 'bhavikmakwana43@gmail.com');
    passwordController = TextEditingController(text: '1234567890');
    confirmPasswordController = TextEditingController(text: '1234567890');
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
  }

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

  GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: BuildConfig.oAuthClientId,
  );

  @action
  Future<bool> loginWithGoogle() async {
    try {
      await _googleSignIn.signIn();
      if (_googleSignIn.currentUser == null) return false;
      final googleAuth = await _googleSignIn.currentUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;
      if (idToken == null) return false;
      Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      return true;
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      return false;
    }
  }

  @action
  Future<bool> signUp() async {
    final email = emailController.text;
    final password = passwordController.text;
    final bool validated = _validateEmailPassword(email, password);
    if (!validated) {
      return false;
    }

    isLoading = true;

    try {
      await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );
      return true;
    } catch (e, st) {
      if (e is PostgrestException) {
        log('Error: ${e.message}', stackTrace: st);
      }
      log(e.toString(), stackTrace: st);
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> login() async {
    final email = emailController.text;
    final password = passwordController.text;
    final bool validated = _validateEmailPassword(email, password);
    if (!validated) {
      return false;
    }
    try {
      isLoading = true;
      await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e, st) {
      if (e is PostgrestException) {
        log('Error: ${e.message}', stackTrace: st);
      }
      log(e.toString(), stackTrace: st);
      return false;
    } finally {
      isLoading = false;
    }
  }

  bool _validateEmailPassword(String email, String password) {
    if (email.isEmpty) {
      return false;
    } else if (password.isEmpty) {
      return false;
    }
    return true;
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
