import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelters/navigation/app_state_cubit/app_state_cubit.dart';
import 'package:shelters/widgets/primary_button.dart';

class MarkerInfoPopUp extends StatelessWidget {
  const MarkerInfoPopUp({
    required this.title,
    required this.description,
    required this.distance,
    required this.isJoined,
    required this.onJoinShelter,
    required this.onNavigate,
    required this.onDeleteShelter,
    Key? key,
  }) : super(key: key);

  final String title;
  final String description;
  final String distance;
  final bool isJoined;
  final VoidCallback onJoinShelter;
  final VoidCallback onNavigate;
  final VoidCallback onDeleteShelter;

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppStateCubit>().state as AuthorizedState).user;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 200),
        child: SingleChildScrollView(
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
                      fontSize: 18,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 5),
                  child: Text(
                    'Description',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
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
                    onPressed: onJoinShelter,
                  ),
                ),
                PrimaryButton(
                  title: 'Open in maps',
                  onPressed: onNavigate,
                ),
                if (user.isAdmin) ...{
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: PrimaryButton(
                      title: 'Delete shelter',
                      onPressed: onDeleteShelter,
                      color: const Color.fromRGBO(204, 46, 46, 1),
                    ),
                  ),
                }
              ],
            ),
          ),
        ),
      ),
    );
  }
}
