import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shelters/flows/menu/presentation/pages/profile/profile_page.dart';
import 'package:shelters/flows/menu/presentation/pages/spots_map/shelters_map_page.dart';
import 'package:shelters/flows/menu/presentation/widgets/navigation_menu_item.dart';
import 'package:shelters/gen/assets.gen.dart';
import 'package:shelters/navigation/app_state_cubit/app_state_cubit.dart';

class MenuItemsList extends StatelessWidget {
  const MenuItemsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppStateCubit>().state as AuthorizedState).user;

    return Expanded(
      child: Column(
        children: [
          NavigationMenuItem(
            title: 'Profile',
            iconPath: Assets.icons.userProfileIcon.path,
            onTap: () => Routemaster.of(context).push(
              ProfilePage.path,
              queryParameters: {
                'name': user.name,
                'email': user.email,
              },
            ),
          ),
          const SizedBox(height: 8),
          NavigationMenuItem(
            title: 'Spots Map',
            iconPath: Assets.icons.menuMap.path,
            onTap: () => Routemaster.of(context).push(SheltersMapPage.path),
          ),
          const Spacer(),
          NavigationMenuItem(
            title: 'Log out',
            iconPath: Assets.icons.logOutIcon.path,
            onTap: () => context.read<AppStateCubit>().logOut(),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
