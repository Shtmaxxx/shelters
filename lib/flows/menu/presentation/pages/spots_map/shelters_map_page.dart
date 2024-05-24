// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shelters/flows/main/presentation/pages/chat_page/chat_page.dart';
import 'package:shelters/flows/menu/presentation/pages/create_marker/create_marker_page.dart';
import 'package:shelters/flows/menu/presentation/pages/spots_map/cubit/map_cubit.dart';
import 'package:shelters/flows/menu/presentation/pages/spots_map/helpers/marker_helper.dart';
import 'package:shelters/flows/menu/presentation/pages/spots_map/widgets/marker_info_pop_up.dart';
import 'package:shelters/navigation/app_state_cubit/app_state_cubit.dart';
import 'package:shelters/services/injectible/injectible_init.dart';
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
                final distance = await MarkerHelper.getDistanceToMarker(
                  state.pressedMarkerPoint.latitude,
                  state.pressedMarkerPoint.longitude,
                );

                await showDialog(
                  context: context,
                  builder: (context) => MarkerInfoPopUp(
                    title: state.pressedMarkerPoint.name,
                    description: state.pressedMarkerPoint.description,
                    distance: '${(distance * 0.001).toStringAsFixed(3)} km',
                    isJoined: state.pressedMarkerPoint.spotJoined,
                    onJoinSpot: () async {
                      Routemaster.of(context).pop();
                      if (state.pressedMarkerPoint.spotJoined) {
                        Routemaster.of(context).push(
                          path + ChatPage.path,
                          queryParameters: {
                            'chatId': state.pressedMarkerPoint.chatId,
                            'chatName': state.pressedMarkerPoint.name,
                            'isGroup': 'true',
                          },
                        );
                      } else {
                        mapCubit.joinSpot(
                          userId: user.id,
                          chatId: state.pressedMarkerPoint.chatId,
                          spotName: state.pressedMarkerPoint.name,
                        );
                      }
                    },
                  ),
                );
                mapCubit.resetMap();
              } else if (state is SpotJoined) {
                mapCubit.getMapMarkers(user.id);
                Routemaster.of(context).push(
                  path + ChatPage.path,
                  queryParameters: {
                    'chatId': state.chatId,
                    'chatName': state.spotName,
                    'isGroup': 'true',
                  },
                );
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
              floatingActionButton: FloatingActionButton(
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
              ),
            ),
          );
        },
      ),
    );
  }
}
