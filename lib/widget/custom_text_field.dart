import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? enabled;
  final bool obscureText;
  final bool autocorrect;
  final int? maxLength;
  final String? hintText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onSubmitted;

  const CustomTextField({
    Key? key,
    this.controller,
    this.enabled,
    this.obscureText = false,
    this.autocorrect = true,
    this.maxLength,
    this.hintText,
    this.focusNode,
    this.textInputAction,
    this.keyboardType,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x19929292),
            blurRadius: 75,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        focusNode: focusNode,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          hintText: hintText,
        ),
        autocorrect: autocorrect,
        obscureText: obscureText,
        maxLength: maxLength,
      ),
    );
  }
}
