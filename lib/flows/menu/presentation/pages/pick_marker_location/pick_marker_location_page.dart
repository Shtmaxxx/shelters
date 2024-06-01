import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shelters/flows/menu/presentation/pages/pick_marker_location/cubit/pick_marker_location_cubit.dart';
import 'package:shelters/services/injectible/injectible_init.dart';
import 'package:shelters/widgets/circular_loading.dart';
import 'package:shelters/widgets/primary_button.dart';

class PickMarkerLocationPage extends StatelessWidget {
  const PickMarkerLocationPage({
    required this.name,
    required this.description,
    super.key,
  });

  static const path = '/pick_marker_location';

  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PickMarkerLocationCubit>()..loadMapData(),
      child: BlocListener<PickMarkerLocationCubit, PickMarkerLocationState>(
        listener: (context, state) {
          if (state is MarkerAdded) {
            Routemaster.of(context).pop(true);
          } else if (state is PickLocationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.failure.message)),
            );
          }
        },
        child: BlocBuilder<PickMarkerLocationCubit, PickMarkerLocationState>(
          builder: (context, state) {
            final pickLocationCubit = context.read<PickMarkerLocationCubit>();

            return Scaffold(
              appBar: AppBar(
                title: const Text('Pick shelter location'),
                leading: IconButton(
                  onPressed: () => Routemaster.of(context).pop(),
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              body: Builder(
                builder: (context) {
                  if (pickLocationCubit.state is! PickMarkerLocationLoading) {
                    return Stack(
                      children: [
                        GoogleMap(
                          initialCameraPosition: context
                              .read<PickMarkerLocationCubit>()
                              .initialCameraPosition,
                          onMapCreated: pickLocationCubit.onMapCreated,
                          zoomControlsEnabled: false,
                          markers: state.markers,
                          mapToolbarEnabled: false,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          onTap: (position) =>
                              pickLocationCubit.onMapPressed(position),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: Platform.isIOS
                                ? MediaQuery.of(context).padding.bottom
                                : 30,
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: PrimaryButton(
                              title: 'Add point',
                              onPressed: () {
                                pickLocationCubit.addMarkerPoint(
                                  name: name,
                                  description: description,
                                  lat: state.markerPoint!.latitude,
                                  lon: state.markerPoint!.longitude,
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    );
                  }
                  return const CircularLoading();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
