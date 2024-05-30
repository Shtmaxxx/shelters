// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shelters/flows/main/presentation/pages/chat_page/chat_page.dart';
import 'package:shelters/flows/menu/presentation/pages/create_marker/create_marker_page.dart';
import 'package:shelters/flows/menu/presentation/pages/shelters_map/cubit/map_cubit.dart';
import 'package:shelters/flows/menu/presentation/pages/shelters_map/helpers/marker_helper.dart';
import 'package:shelters/flows/menu/presentation/pages/shelters_map/widgets/marker_info_pop_up.dart';
import 'package:shelters/navigation/app_state_cubit/app_state_cubit.dart';
import 'package:shelters/services/injectible/injectible_init.dart';
import 'package:shelters/widgets/app_alert_dialog.dart';
import 'package:shelters/widgets/circular_loading.dart';
import 'package:shelters/widgets/info_pop_up.dart';

class SheltersMapPage extends StatelessWidget {
  const SheltersMapPage({super.key});

  static const String path = '/spots_map';

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppStateCubit>().state as AuthorizedState).user;

    return BlocProvider(
      create: (context) => getIt<MapCubit>()..initMapData(user.id),
      child: Builder(
        builder: (context) {
          final mapCubit = context.read<MapCubit>();

          return BlocListener<MapCubit, MapState>(
            listener: (context, state) async {
              if (state is MarkerPressed) {
                final pressedMarker = state.pressedMarkerPoint;
                final distance = await MarkerHelper.getDistanceToMarker(
                  pressedMarker.latitude,
                  pressedMarker.longitude,
                );

                await showDialog(
                  context: context,
                  builder: (context) => MarkerInfoPopUp(
                    title: pressedMarker.name,
                    description: pressedMarker.description,
                    distance: '${(distance * 0.001).toStringAsFixed(3)} km',
                    isJoined: pressedMarker.shelterJoined,
                    onJoinSpot: () async {
                      Routemaster.of(context).pop();
                      if (pressedMarker.shelterJoined) {
                        final result = await Routemaster.of(context).push<bool>(
                          path + ChatPage.path,
                          queryParameters: {
                            'chatId': pressedMarker.chatId,
                            'chatName': pressedMarker.name,
                            'isGroup': 'true',
                          },
                        ).result;
                        if (result ?? false) {
                          mapCubit.getMapMarkers(user.id);
                        }
                      } else {
                        mapCubit.joinSpot(
                          userId: user.id,
                          chatId: pressedMarker.chatId,
                          spotName: pressedMarker.name,
                        );
                      }
                    },
                    onNavigate: () => mapCubit.openMapsBottomSheet(
                      context: context,
                      markerPoint: pressedMarker,
                    ),
                    onDeleteShelter: () => AppAlertDialog.show(
                      context: context,
                      title: 'Confirmation',
                      message:
                          'Are you sure you want to delete ${pressedMarker.name} shelter?',
                      actionTitle: 'Delete',
                      onActionPressed: () {
                        Routemaster.of(context).pop();
                        mapCubit.deleteShelter(
                          markerId: pressedMarker.id,
                          chatId: pressedMarker.chatId,
                        );
                      },
                    ),
                  ),
                );
                mapCubit.resetMap();
              } else if (state is ShelterJoined) {
                mapCubit.getMapMarkers(user.id);
                Routemaster.of(context).push(
                  path + ChatPage.path,
                  queryParameters: {
                    'chatId': state.chatId,
                    'chatName': state.spotName,
                    'isGroup': 'true',
                  },
                );
              } else if (state is MarkerDeleted) {
                mapCubit.getMapMarkers(user.id);
              } else if (state is MapError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.failure.message)),
                );
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Shelters Map'),
              ),
              body: BlocBuilder<MapCubit, MapState>(
                builder: (context, state) {
                  if (state is! Loading) {
                    return Stack(
                      children: [
                        GoogleMap(
                          initialCameraPosition: state.initialCameraPosition,
                          onMapCreated: mapCubit.onMapCreated,
                          onCameraMove: (position) =>
                              mapCubit.onCameraMoved(position.zoom),
                          zoomControlsEnabled: false,
                          markers: state.markers,
                          mapToolbarEnabled: false,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                        ),
                      ],
                    );
                  }
                  return const CircularLoading();
                },
              ),
              floatingActionButton: user.isAdmin
                  ? FloatingActionButton(
                      onPressed: () async {
                        final result = await Routemaster.of(context)
                            .push<bool>(path + CreateMarkerPage.path)
                            .result;
                        if (result ?? false) {
                          mapCubit.getMapMarkers(user.id);
                          showDialog(
                            context: context,
                            builder: (context) => const InfoPopUp(
                              title: 'Success!',
                              info: 'Shelter has been added successfully!',
                            ),
                          );
                        }
                      },
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        Icons.add,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
