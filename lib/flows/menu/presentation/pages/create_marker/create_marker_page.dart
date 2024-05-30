import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shelters/flows/menu/presentation/pages/create_marker/cubit/create_marker_cubit.dart';
import 'package:shelters/flows/menu/presentation/pages/pick_marker_location/pick_marker_location_page.dart';
import 'package:shelters/services/injectible/injectible_init.dart';
import 'package:shelters/widgets/app_text_field.dart';
import 'package:shelters/widgets/primary_button.dart';

class CreateMarkerPage extends StatelessWidget {
  const CreateMarkerPage({super.key});

  static const String path = '/create_marker';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateMarkerCubit>(),
      child: BlocListener<CreateMarkerCubit, CreateMarkerState>(
        listener: (context, state) {
          if (state is CreateMarkerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.failure.message)),
            );
          }
        },
        child: Builder(builder: (context) {
          final createMarkerCubit = context.read<CreateMarkerCubit>();

          return Scaffold(
            appBar: AppBar(
              title: const Text('Create Marker'),
            ),
            body: GestureDetector(
              onTap: () {
                if (createMarkerCubit.focusNode.hasFocus) {
                  createMarkerCubit.focusNode.unfocus();
                }
              },
              behavior: HitTestBehavior.translucent,
              child: Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                          child: Form(
                            key: createMarkerCubit.formKey,
                            child: Column(
                              children: [
                                AppTextField(
                                  label: 'Shelter name',
                                  controller: createMarkerCubit.titleController,
                                  color: Theme.of(context).primaryColor,
                                  errorColor: Colors.red,
                                  validator: (input) {
                                    if (input?.isEmpty ?? true) {
                                      return 'The field should not be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                AppTextField(
                                  label: 'Description',
                                  controller:
                                      createMarkerCubit.descriptionController,
                                  color: Theme.of(context).primaryColor,
                                  errorColor: Colors.red,
                                  validator: (input) {
                                    if (input?.trim().isEmpty ?? true) {
                                      return 'The field should not be empty';
                                    }
                                    return null;
                                  },
                                  focusNode: createMarkerCubit.focusNode,
                                  maxLength: 200,
                                  maxLines: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 20,
                      ),
                      child: PrimaryButton(
                        onPressed: () async {
                          final routemaster = Routemaster.of(context);
                          final formState =
                              createMarkerCubit.formKey.currentState;
                          if (formState?.validate() ?? false) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            final markerAdded = await routemaster.push<bool>(
                                routemaster.currentRoute.path +
                                    PickMarkerLocationPage.path,
                                queryParameters: {
                                  'name':
                                      createMarkerCubit.titleController.text,
                                  'description': createMarkerCubit
                                      .descriptionController.text,
                                }).result;
                            if (markerAdded ?? false) {
                              routemaster.pop(true);
                            }
                          }
                        },
                        title: 'Next',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
