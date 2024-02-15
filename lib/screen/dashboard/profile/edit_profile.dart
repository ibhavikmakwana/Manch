import 'package:flutter/material.dart';
import 'package:manch/screen/dashboard/profile/store/profile_screen_store.dart';

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
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      '${store?.userProfile?.avatarUrl}',
                    ),
                    radius: 48,
                    onBackgroundImageError: (_, st) {},
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: store?.userNameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
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
                    decoration: InputDecoration(
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
                    decoration: InputDecoration(
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
