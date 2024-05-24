import 'package:flutter/material.dart';
import 'package:shelters/widgets/default_user_avatar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    required this.name,
    this.email,
    super.key,
  });

  static const String path = '/profile';

  final String name;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: DefaultUserAvatar(
                letter: name[0],
                size: 100,
                fontSize: 48,
              ),
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 28),
            ),
            email != null
                ? Text(
                    email!,
                    style: const TextStyle(fontSize: 14),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
