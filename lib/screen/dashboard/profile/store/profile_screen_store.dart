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

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:supabase_playground/models/user_profile.dart';

part 'profile_screen_store.g.dart';

class ProfileScreenStore = _ProfileScreenStore with _$ProfileScreenStore;

abstract class _ProfileScreenStore with Store {
  _ProfileScreenStore() {
    _init();
  }

  late final TextEditingController userNameController;

  _init() async {
    userNameController = TextEditingController();
    // await getProfile();
  }

  @observable
  UserProfile? userProfile;

  /*@action
  Future<void> getProfile() async {
    final userPref = await SharedPreference.instance?.storage
        .read(key: AppConstant.kCurrentUser);
    if (userPref != null) {
      try {
        userProfile = JsonMapper.deserialize(userPref);
        final response = await SBClient.instance?.client
            .from('profiles')
            .select()
            .eq('id', '${userProfile?.id}')
            .single()
            .execute();
        if (response?.error != null) {
          log('Error: ${response?.error?.message}');
        } else {
          final encodedData = json.encode(response?.data);
          if (encodedData != userPref) {
            final decodedData = json.decode(encodedData);
            userProfile = JsonMapper.deserialize<UserProfile>(decodedData);
            SharedPreference.instance?.storage
                .write(key: AppConstant.kCurrentUser, value: encodedData);
          }
        }
        print('${userProfile?.username}');
      } catch (e) {
        log(e.toString());
      }
    }
  }*/

  /*@action
  Future<bool> updateProfile() async {
    try {
      userProfile = userProfile?.copyWith(
        username: '${userNameController.text}',
      );

      // {
      //   'user_name': 'bhavik',
      //   'updated_at': DateTime.now().toIso8601String()
      // },
      final requestBody = JsonMapper.toMap(
        userProfile,
        SerializationOptions(ignoreNullMembers: true),
      );
      final response = await SBClient.instance?.client
          .from('profiles')
          .update(
            JsonMapper.toMap(
              UserProfile(
                id: userProfile?.id,
                firstName: 'Bhavik',
                lastName: 'Makwana',
                about: 'test',
                avatarUrl: 'test',
                username: 'bhavik',
                email: userProfile?.email,
              ),
              SerializationOptions(ignoreNullMembers: true),
            )!,
          )
          .eq('id', '${userProfile?.id}')
          .execute();
      if (response?.error != null) {
        log('Error: ${response?.toJson()}');
        return false;
      } else {
        log('Success Response: ${response?.toJson()}');
        await getProfile();
        return true;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }*/
}
