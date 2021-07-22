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
import 'package:mobx/mobx.dart';

part 'user_profile.g.dart';

@jsonSerializable
class UserProfile extends _UserProfile with _$UserProfile {
  UserProfile({
    final String? id,
    String? email,
    String? username,
    String? avatarUrl,
    String? about,
    String? name,
  }) : super(
          id: id,
          email: email,
          username: username,
          avatarUrl: avatarUrl,
          about: about,
          name: name,
        );
}

@jsonSerializable
abstract class _UserProfile with Store {
  @JsonProperty(name: 'id')
  late final String? id;

  @JsonProperty(name: 'email')
  String? email;

  @JsonProperty(name: 'user_name')
  String? username;

  @JsonProperty(name: 'name')
  String? name;

  @JsonProperty(name: 'avatar_url')
  String? avatarUrl;

  @JsonProperty(name: 'about')
  String? about;

  _UserProfile({
    this.id,
    this.email,
    this.username,
    this.avatarUrl,
    this.about,
    this.name,
  });

  UserProfile copyWith({
    String? email,
    String? username,
    String? name,
    String? avatarUrl,
    String? about,
  }) {
    return UserProfile(
      id: id,
      email: this.email = email ?? this.email,
      username: this.username = username ?? this.username,
      name: this.name = name ?? this.name,
      avatarUrl: this.avatarUrl = avatarUrl ?? this.avatarUrl,
      about: this.about = about ?? this.about,
    );
  }
}
