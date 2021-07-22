import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerOptionsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Camera'),
            onTap: () {
              Navigator.of(context).pop(ImageSource.camera);
            },
          ),
          ListTile(
            title: const Text('Gallery'),
            onTap: () {
              Navigator.of(context).pop(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }
}
