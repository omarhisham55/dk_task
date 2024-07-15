import 'package:flutter/material.dart';

class DefualtTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final EdgeInsets? padding;
  final bool? obsecure;
  final Widget? suffixIcon;
  const DefualtTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.validator,
    this.padding = EdgeInsets.zero,
    this.obsecure = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obsecure!,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.only(left: 10),
          suffix: suffixIcon,
        ),
      ),
    );
  }
}
