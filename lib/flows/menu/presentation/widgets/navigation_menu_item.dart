import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavigationMenuItem extends StatelessWidget {
  const NavigationMenuItem({
    required this.title,
    required this.iconPath,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final String title;
  final String iconPath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            SvgPicture.asset(iconPath),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).primaryTextTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
