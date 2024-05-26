import 'package:flutter/material.dart';
import 'package:shelters/widgets/primary_button.dart';

class MarkerInfoPopUp extends StatelessWidget {
  const MarkerInfoPopUp({
    required this.title,
    required this.description,
    required this.distance,
    required this.isJoined,
    required this.onJoinSpot,
    required this.onNavigate,
    Key? key,
  }) : super(key: key);

  final String title;
  final String description;
  final String distance;
  final bool isJoined;
  final VoidCallback onJoinSpot;
  final VoidCallback onNavigate;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Description',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Theme.of(context).primaryColor.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text(
                  'Distance: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  distance,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Theme.of(context).primaryColor.withOpacity(0.8),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 10),
              child: PrimaryButton(
                title: isJoined ? 'Open chat' : 'Join shelter',
                onPressed: onJoinSpot,
                verticalPadding: 12,
              ),
            ),
            PrimaryButton(
              title: 'Open in maps',
              onPressed: onNavigate,
              verticalPadding: 12,
            ),
          ],
        ),
      ),
    );
  }
}
