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
import 'package:flutter/material.dart';
import 'package:manch/core/routes/routes.dart';
import 'package:manch/core/routes/routes_name.dart';
import 'package:manch/l10n/app_localizations.dart';
import 'package:manch/screen/dashboard/home/store/home_screen_store.dart';
import 'package:manch/screen/dashboard/profile/store/profile_screen_store.dart';
import 'package:manch/values/extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeScreenStore(profileStore: ProfileScreenStore()).fetchPosts();
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
                await Supabase.instance.client.auth.signOut();
                goRouter.goNamedAndRemoveUntil(RoutesName.loginSignup.name);
              },
              child: Text(
                '${AppLocalizations.of(context)?.logOut}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
