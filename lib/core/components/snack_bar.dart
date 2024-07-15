import 'package:flutter/material.dart';

showSnackBar({
  required BuildContext context,
  required String text,
  Duration? duration,
  Color? color,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: duration ?? const Duration(seconds: 3),
      backgroundColor: color,
    ),
  );
}
