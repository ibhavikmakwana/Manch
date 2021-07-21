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

import 'dart:convert';
import 'dart:developer';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_playground/models/user_profile.dart';
import 'package:supabase_playground/widget/base_widget_switcher.dart';

part 'profile_screen_store.g.dart';

class ProfileScreenStore = _ProfileScreenStore with _$ProfileScreenStore;

abstract class _ProfileScreenStore with Store {
  _ProfileScreenStore() {
    _init();
  }

  late final TextEditingController userNameController;
  late final TextEditingController nameController;
  late final TextEditingController aboutController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  _init() async {
    await getProfile();
    userNameController = TextEditingController(text: userProfile?.username);
    nameController = TextEditingController(text: userProfile?.name);
    aboutController = TextEditingController(text: userProfile?.about);
  }

  @observable
  UserProfile? userProfile;

  @observable
  bool editProfile = false;

  @observable
  BaseWidgetState profileScreenState = BaseWidgetState.LOADING;

  @action
  Future<void> getProfile({bool showLoader = false}) async {
    try {
      if (showLoader) profileScreenState = BaseWidgetState.LOADING;
      final userId = Supabase.instance.client.auth.currentUser?.id;
      final response = await Supabase.instance.client
          .from('profiles')
          .select()
          .eq('id', '$userId')
          .single()
          .execute();
      if (response.error != null) {
        profileScreenState = BaseWidgetState.ERROR;
        log('Error: ${response.error?.message}');
      } else {
        final encodedData = json.encode(response.data);
        final decodedData = json.decode(encodedData);
        profileScreenState = BaseWidgetState.SUCCESS;
        userProfile = JsonMapper.deserialize<UserProfile>(decodedData);
        editProfile =
            userProfile?.name == null || userProfile?.username == null;
      }
    } catch (e) {
      profileScreenState = BaseWidgetState.ERROR;
      log(e.toString());
    }
  }

  @action
  Future<void> updateProfile() async {
    /// TODO: Add a better validations (Bhavik Makwana)
    if (formKey.currentState!.validate()) {
      try {
        userProfile = userProfile?.copyWith(
          username: '${userNameController.text.trim()}',
          name: '${nameController.text.trim()}',
          about: '${aboutController.text.trim()}',
        );

        final requestBody = JsonMapper.toMap(
          userProfile,
          SerializationOptions(ignoreNullMembers: true),
        );
        final response = await Supabase.instance.client
            .from('profiles')
            .update(requestBody!)
            .eq('id', '${userProfile?.id}')
            .execute();

        if (response.error != null) {
          log('Error: ${response.toJson()}');
        } else {
          log('Success Response: ${response.toJson()}');
          await getProfile();
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  @action
  Future<void> uploadAvatar() async {
    // TODO: Implement Upload Avatar of the user (Bhavik Makwana).
  }

  void dispose() {
    userNameController.dispose();
    nameController.dispose();
    aboutController.dispose();
  }
}
