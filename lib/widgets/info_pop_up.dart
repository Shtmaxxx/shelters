import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shelters/widgets/primary_button.dart';

class InfoPopUp extends StatelessWidget {
  const InfoPopUp({
    required this.title,
    required this.info,
    super.key,
  });

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 17,
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              info,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: PrimaryButton(
                title: 'Great!',
                onPressed: Routemaster.of(context).pop,
                verticalPadding: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
