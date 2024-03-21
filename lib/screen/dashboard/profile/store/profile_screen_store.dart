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
import 'package:manch/data/repositories/user_profile_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:manch/data/models/user_profile.dart';
import 'package:manch/widget/base_widget_switcher.dart';

part 'profile_screen_store.g.dart';

class ProfileScreenStore = _ProfileScreenStore with _$ProfileScreenStore;

abstract class _ProfileScreenStore with Store {
  final UserProfileRepository _repository = UserProfileRepository();
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
      userProfile = await _repository.getProfile();
      editProfile = userProfile?.name == null || userProfile?.username == null;
      profileScreenState = BaseWidgetState.SUCCESS;
    } catch (e, st) {
      if (e is PostgrestException) {
        profileScreenState = BaseWidgetState.ERROR;
        log('Error: ${e.message}');
      }
      profileScreenState = BaseWidgetState.ERROR;
      log(e.toString(), stackTrace: st);
    }
  }

  @action
  Future<void> updateProfile() async {
    /// TODO: Add a better validations (Bhavik Makwana)
    if (formKey.currentState!.validate()) {
      try {
        userProfile = userProfile?.copyWith(
          email: userProfile?.email,
          avatarUrl: userProfile?.avatarUrl,
          username: userNameController.text.trim(),
          name: nameController.text.trim(),
          about: aboutController.text.trim(),
        );
        userProfile = await _repository.updateProfile(userProfile!);
        editProfile = userProfile?.name == null || userProfile?.username == null;
      } catch (e, st) {
        if (e is PostgrestException) {
          log('Error: ${e.message}');
        }
        log(e.toString(), stackTrace: st);
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
