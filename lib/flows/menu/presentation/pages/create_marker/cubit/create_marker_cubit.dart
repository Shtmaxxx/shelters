import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shelters/domain/core/errors/failures.dart';

part 'create_marker_state.dart';

@injectable
class CreateMarkerCubit extends Cubit<CreateMarkerState> {
  CreateMarkerCubit()
      : focusNode = FocusNode(),
        formKey = GlobalKey<FormState>(),
        titleController = TextEditingController(),
        descriptionController = TextEditingController(),
        super(CreateMarkerInitial());

  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final FocusNode focusNode;
}
