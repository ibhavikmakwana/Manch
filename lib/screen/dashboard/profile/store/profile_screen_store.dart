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
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart';
import 'package:postgrest/src/postgrest_response.dart';
import 'package:storage_client/src/fetch.dart' show StorageResponse;
import 'package:storage_client/src/types.dart' show FileOptions;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_playground/models/user_profile.dart';
import 'package:supabase_playground/screen/dashboard/profile/widget/image_picker_options_dialog.dart';
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

  Future<void> _init() async {
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
  BaseWidgetState profileScreenState = BaseWidgetState.loading;

  @action
  Future<void> getProfile({bool showLoader = false}) async {
    try {
      if (showLoader) profileScreenState = BaseWidgetState.loading;
      final userId = Supabase.instance.client.auth.currentUser?.id;
      final response = await Supabase.instance.client
          .from('profiles')
          .select()
          .eq('id', userId)
          .single()
          .execute();
      if (response.error != null) {
        profileScreenState = BaseWidgetState.error;
        log('Error: ${response.error?.message}');
      } else {
        _populateUserProfile(response);
        editProfile =
            userProfile?.name == null || userProfile?.username == null;
      }
    } catch (e) {
      profileScreenState = BaseWidgetState.error;
      log(e.toString());
    }
  }

  void _populateUserProfile(PostgrestResponse response) {
    final encodedData = json.encode(response.data);
    final decodedData = json.decode(encodedData);
    profileScreenState = BaseWidgetState.success;
    userProfile = JsonMapper.deserialize<UserProfile>(decodedData);
  }

  @action
  Future<void> updateProfile({bool doValidate = true}) async {
    if (doValidate) {
      formKey.currentState!.validate();
      return;
    }

    try {
      userProfile = userProfile?.copyWith(
        username: userNameController.text.trim(),
        name: nameController.text.trim(),
        about: aboutController.text.trim(),
      );

      final requestBody = JsonMapper.toMap(
        userProfile,
        const SerializationOptions(ignoreNullMembers: true),
      );
      final response = await Supabase.instance.client
          .from('profiles')
          .upsert(requestBody)
          .execute();

      if (response.error != null) {
        log('Error: ${response.toJson()}');
      } else {
        log('Success Response: ${response.toJson()}');
        _populateUserProfile(response);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @action
  Future<void> uploadAvatar(BuildContext context) async {
    final ImageSource? imageSource = await showDialog(
        context: context,
        builder: (_) {
          return ImagePickerOptionsDialog();
        });

    if (imageSource == null) return;
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      final size = await pickedFile.length();
      if (size > 3000000) {
        throw "The file is too large. Allowed maximum size is 3 MB.";
      }
      final bytes = await pickedFile.readAsBytes();
      const fileOptions = FileOptions(upsert: true);
      final imageExt = extension(pickedFile.path);
      final fileName = userProfile?.id;

      StorageResponse<String> response;

      response = await Supabase.instance.client.storage
          .from('avatars')
          .uploadBinary('$fileName$imageExt', bytes, fileOptions: fileOptions);

      if (response.hasError) {
        log('Status code: ${response.error?.statusCode}\nError: ${response.error?.error}\nMessage: ${response.error?.message}');
      } else {
        log('Success response: ${response.data}');
        final avatarURL = await Supabase.instance.client.storage
            .from('avatars')
            .createSignedUrl('$fileName$imageExt', 30 * 100);
        userProfile = userProfile?.copyWith(avatarUrl: avatarURL.data);
        updateProfile(doValidate: false);
      }
    }
  }

  void dispose() {
    userNameController.dispose();
    nameController.dispose();
    aboutController.dispose();
  }
}
