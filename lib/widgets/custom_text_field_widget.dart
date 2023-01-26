import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  const CustomTextFieldWidget(
      this.hint, {
        super.key,
        required this.controller,
      });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      controller: controller,
      decoration: InputDecoration(hintText: hint),
    );
  }
}
