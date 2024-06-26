import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.onPressed,
    required this.title,
    this.verticalPadding = 12,
    this.color,
    this.titleColor,
    super.key,
  });

  final VoidCallback onPressed;
  final String title;
  final double verticalPadding;
  final Color? color;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color:
                      titleColor ?? Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
