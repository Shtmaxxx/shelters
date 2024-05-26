import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shelters/flows/menu/presentation/widgets/navigation_menu_item.dart';
import 'package:shelters/gen/assets.gen.dart';

class NavigationMenuHeader extends StatelessWidget {
  const NavigationMenuHeader({
    required this.username,
    Key? key,
  }) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 60),
        SvgPicture.asset(Assets.icons.menuLogo.path),
        const SizedBox(height: 16),
        Text(
          'Shelters Finder',
          style: Theme.of(context).primaryTextTheme.titleLarge?.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 32),
        NavigationMenuItem(
          title: username,
          iconPath: Assets.icons.profileName.path,
        ),
        const SizedBox(height: 12),
        Container(
          height: 1,
          width: double.infinity,
          color: const Color(0xFFFFFFFF).withOpacity(0.3),
        ),
      ],
    );
  }
}
