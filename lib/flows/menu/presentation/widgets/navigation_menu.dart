import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelters/flows/menu/presentation/widgets/menu_items_list.dart';
import 'package:shelters/flows/menu/presentation/widgets/navigation_menu_header.dart';
import 'package:shelters/navigation/app_state_cubit/app_state_cubit.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppStateCubit>().state as AuthorizedState).user;

    return Drawer(
      width: (MediaQuery.of(context).size.width + 100) / 2,
      backgroundColor: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
        child: Column(
          children: [
            NavigationMenuHeader(username: user.name),
            const SizedBox(height: 8),
            const MenuItemsList(),
          ],
        ),
      ),
    );
  }
}
