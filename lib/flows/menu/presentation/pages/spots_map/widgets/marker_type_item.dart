import 'package:flutter/material.dart';

class MarkerTypeItem extends StatelessWidget {
  const MarkerTypeItem({
    required this.title,
    required this.color,
    super.key,
  });

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
        ),
        color: color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }
}
