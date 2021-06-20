import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:supabase_playground/core/supabase/prefrence.dart';
import 'package:supabase_playground/core/supabase/supabase_client.dart';
import 'package:supabase_playground/values/routes.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              await SBClient.instance?.client.auth.signOut();
              await SharedPreference.instance?.storage.deleteAll();
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.login,
                ModalRoute.withName(Routes.initial),
              );
            },
            child: Text(
              '${AppLocalizations.of(context)?.logOut}',
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ],
      ),
    );
  }
}
