import 'package:flutter/material.dart';
import 'package:supabase_playground/screen/dashboard/profile/store/profile_screen_store.dart';
import 'package:supabase_playground/widget/network_cache_images.dart';

class EditProfile extends StatelessWidget {
  final ProfileScreenStore? store;

  const EditProfile({Key? key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text(
            'Edit Profile',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          actions: [
            IconButton(
              onPressed: store?.updateProfile,
              icon: Icon(
                Icons.check_outlined,
                color: Theme.of(context).appBarTheme.titleTextStyle?.color,
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: store?.formKey,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      store?.uploadAvatar(context);
                    },
                    child: NetworkCacheImages(
                      imageUrl: store?.userProfile?.avatarUrl,
                      radius: 48,
                      circleAvatar: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: store?.userNameController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'Enter User Name',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter user name.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: store?.nameController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'Enter Name',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: store?.aboutController,
                    textInputAction: TextInputAction.done,
                    maxLines: 4,
                    maxLength: 150,
                    decoration: const InputDecoration(
                      hintText: 'About you',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
