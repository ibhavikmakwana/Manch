import 'package:flutter/material.dart';
import 'package:supabase_playground/screen/dashboard/profile/store/profile_screen_store.dart';

class ViewProfile extends StatelessWidget {
  final ProfileScreenStore? store;

  const ViewProfile({Key? key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppBar(
          title: Text(
            'Profile',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          actions: [
            IconButton(
              onPressed: () => store?.editProfile = true,
              icon: Icon(
                Icons.edit_outlined,
                color: Theme.of(context).appBarTheme.titleTextStyle?.color,
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage('${store?.userProfile?.avatarUrl}'),
                      radius: 48,
                      onBackgroundImageError: (_, st) {},
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${store?.userProfile?.name}',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '@${store?.userProfile?.username}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (store?.userProfile?.about != null) ...{
                  Text(
                    '${store?.userProfile?.about}',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(height: 16),
                },
              ],
            ),
          ),
        ),
      ],
    );
  }
}
