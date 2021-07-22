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
import 'dart:io';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_playground/models/user_profile.dart';
import 'package:supabase_playground/screen/dashboard/profile/widget/image_picker_options_dialog.dart';
import 'package:supabase_playground/values/app_colors.dart';
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
        final encodedData = json.encode(response.data);
        final decodedData = json.decode(encodedData);
        profileScreenState = BaseWidgetState.success;
        userProfile = JsonMapper.deserialize<UserProfile>(decodedData);
        editProfile =
            userProfile?.name == null || userProfile?.username == null;
      }
    } catch (e) {
      profileScreenState = BaseWidgetState.error;
      log(e.toString());
    }
  }

  @action
  Future<void> updateProfile({bool doValidate = true}) async {
    /// TODO: Add a better validations (Bhavik Makwana)
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
          .update(requestBody!)
          .eq('id', userProfile?.id)
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

  @action
  Future<void> uploadAvatar(BuildContext context) async {
    final ImageSource? imageSource = await showDialog(
        context: context,
        builder: (_) {
          return ImagePickerOptionsDialog();
        });
    if (imageSource != null) {
      final file = await getImage(imageSource);

      final imageExt = extension(file!.path);
      final fileName = userProfile?.id;

      final response = await Supabase.instance.client.storage
          .from('avatars')
          .upload('$fileName$imageExt', file);

      if (response.hasError) {
        log('Status code: ${response.error?.statusCode}\nError: ${response.error?.error}\nMessage: ${response.error?.message}');
      } else {
        log('Success response: ${response.data}');
        final avatarURL = Supabase.instance.client.storage
            .from('avatars')
            .getPublicUrl('$fileName$imageExt')
            .data;
        userProfile = userProfile?.copyWith(avatarUrl: avatarURL);
        updateProfile(doValidate: false);
      }
    }
  }

  Future<File?> getImage(ImageSource imageSource) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: imageSource);
    return ImageCropper.cropImage(
      sourcePath: image!.path,
      cropStyle: CropStyle.circle,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Crop image',
        toolbarColor: AppColors.dark,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      iosUiSettings: const IOSUiSettings(
        minimumAspectRatio: 1.0,
        title: 'Crop image',
      ),
    );
  }

  void dispose() {
    userNameController.dispose();
    nameController.dispose();
    aboutController.dispose();
  }
}
