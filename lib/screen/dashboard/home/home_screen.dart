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

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:supabase_playground/screen/dashboard/home/store/home_screen_store.dart';
import 'package:supabase_playground/screen/dashboard/profile/store/profile_screen_store.dart';
import 'package:supabase_playground/values/extensions.dart';
import 'package:supabase_playground/values/routes.dart';
import 'package:supabase_playground/widget/custom_text_field.dart';
import 'package:supabase_playground/widget/network_cache_images.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeScreenStore _homeScreenStore;
  late final ReactionDisposer _reactionDisposer;

  @override
  void initState() {
    super.initState();
    final profileStore = context.read<ProfileScreenStore>();
    _homeScreenStore = HomeScreenStore(profileStore: profileStore);
    _homeScreenStore.fetchPosts();
    _reactionDisposer = when(
      (_) => _homeScreenStore.errorMessage != null,
      () {
        context.showSnackBar(
          _homeScreenStore.errorMessage!,
        );
      },
    );
  }

  @override
  void dispose() {
    _reactionDisposer.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text(
            'Home',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          centerTitle: false,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () async {
                // await SBClient.instance?.client.auth.signOut();
                // await SharedPreference.instance?.storage.deleteAll();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.login,
                  ModalRoute.withName(Routes.initial),
                );
              },
              child: Text(
                AppLocalizations.of(context)?.logOut ?? '',
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _homeScreenStore.postFormKey,
            child: CustomTextField(
              controller: _homeScreenStore.postController,
              hintText: 'Share post',
              maxLines: 3,
              textInputAction: TextInputAction.send,
              maxLength: 150,
              onSubmitted: (value) {
                _homeScreenStore.sharePost();
              },
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'Please add some text.';
                }
              },
            ),
          ),
        ),
        Observer(builder: (_) {
          if (_homeScreenStore.postList.isEmpty) return const SizedBox.shrink();
          return Expanded(
            child: ListView.builder(
              itemCount: _homeScreenStore.postList.length,
              itemBuilder: (_, index) {
                final post = _homeScreenStore.postList[index];
                log('${post.userMeta?['avatar_url']}');
                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          NetworkCacheImages(
                            imageUrl: '${post.userMeta?['avatar_url']}',
                            radius: 20,
                            circleAvatar: true,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${post.userMeta?['name']}',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        post.post,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        post.insertedAt.timeAgo,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
