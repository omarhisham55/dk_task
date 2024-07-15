import 'package:flutter/material.dart';

class DefualtButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  const DefualtButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.padding,
    this.margin = EdgeInsets.zero,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin!,
      child: MaterialButton(
        minWidth: width ?? double.infinity,
        onPressed: onPressed,
        padding: padding,
        color: const Color(0xFF353953),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
