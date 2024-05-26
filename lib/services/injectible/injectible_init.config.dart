// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i14;
import 'package:shared_preferences/shared_preferences.dart' as _i15;

import '../../domain/auth/datasource/auth_datasource.dart' as _i19;
import '../../domain/auth/repository/auth_repo.dart' as _i20;
import '../../domain/auth/repository/auth_repo_impl.dart' as _i21;
import '../../flows/auth/data/repositories/auth_repository_impl.dart' as _i23;
import '../../flows/auth/domain/repositories/auth_repository.dart' as _i22;
import '../../flows/auth/domain/usecases/sign_in.dart' as _i35;
import '../../flows/auth/domain/usecases/sign_out.dart' as _i36;
import '../../flows/auth/domain/usecases/sign_up.dart' as _i37;
import '../../flows/auth/presentation/pages/sign_in/cubit/sign_in_cubit.dart'
    as _i41;
import '../../flows/auth/presentation/pages/sign_up/cubit/sign_up_cubit.dart'
    as _i42;
import '../../flows/main/data/datasources/chats_datasource.dart' as _i24;
import '../../flows/main/data/repositories/chats_repository_impl.dart' as _i26;
import '../../flows/main/domain/repositories/chats_repository.dart' as _i25;
import '../../flows/main/domain/usecases/get_chat_messages.dart' as _i27;
import '../../flows/main/domain/usecases/get_users_chats.dart' as _i29;
import '../../flows/main/domain/usecases/join_chat_group.dart' as _i30;
import '../../flows/main/domain/usecases/leave_chat_group.dart' as _i31;
import '../../flows/main/domain/usecases/send_message.dart' as _i34;
import '../../flows/main/presentation/pages/chat_page/cubit/messages_cubit.dart'
    as _i40;
import '../../flows/main/presentation/pages/main/cubit/chats_cubit.dart'
    as _i39;
import '../../flows/menu/data/datasources/markers_datasource.dart' as _i11;
import '../../flows/menu/data/repositories/markers_repository_impl.dart'
    as _i13;
import '../../flows/menu/domain/repositories/markers_repository.dart' as _i12;
import '../../flows/menu/domain/usecases/add_marker_point.dart' as _i18;
import '../../flows/menu/domain/usecases/get_markers.dart' as _i28;
import '../../flows/menu/presentation/pages/create_marker/cubit/cubit/create_marker_cubit.dart'
    as _i3;
import '../../flows/menu/presentation/pages/pick_marker_location/cubit/pick_marker_location_cubit.dart'
    as _i33;
import '../../flows/menu/presentation/pages/shelters_map/cubit/map_cubit.dart'
    as _i32;
import '../../flows/splash/presentation/pages/splash/cubit/splash_cubit.dart'
    as _i16;
import '../../navigation/app_state_cubit/app_state_cubit.dart' as _i38;
import '../../themes/theme_data_values.dart' as _i17;
import '../firestore/firestore_chats.dart' as _i6;
import '../firestore/firestore_markers.dart' as _i7;
import '../firestore/firestore_messages.dart' as _i8;
import '../firestore/firestore_users.dart' as _i9;
import 'injectible_init.dart' as _i43; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.factory<_i3.CreateMarkerCubit>(() => _i3.CreateMarkerCubit());
  gh.lazySingleton<_i4.FirebaseAuth>(() => registerModule.firebaseAuth);
  gh.lazySingleton<_i5.FirebaseFirestore>(() => registerModule.firestore);
  gh.factory<_i6.FirestoreChats>(
      () => _i6.FirestoreChats(get<_i5.FirebaseFirestore>()));
  gh.factory<_i7.FirestoreMarkers>(
      () => _i7.FirestoreMarkers(get<_i5.FirebaseFirestore>()));
  gh.factory<_i8.FirestoreMessages>(
      () => _i8.FirestoreMessages(get<_i5.FirebaseFirestore>()));
  gh.factory<_i9.FirestoreUsers>(
      () => _i9.FirestoreUsers(get<_i5.FirebaseFirestore>()));
  gh.lazySingleton<_i10.FlutterSecureStorage>(
      () => registerModule.flutterSecureStorage);
  gh.factory<_i11.MarkersDatasourceI>(() => _i11.MarkersDatasourceImpl(
      firestoreMarkers: get<_i7.FirestoreMarkers>()));
  gh.factory<_i12.MarkersRepositoryI>(
      () => _i13.MarkersRepositoryImpl(get<_i11.MarkersDatasourceI>()));
  await gh.factoryAsync<_i14.PackageInfo>(
    () => registerModule.packageInfo,
    preResolve: true,
  );
  await gh.factoryAsync<_i15.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.factory<_i16.SplashCubit>(() => _i16.SplashCubit());
  gh.lazySingleton<_i17.ThemeDataValues>(() => _i17.ThemeDataValues());
  gh.factory<_i18.AddMarkerPointUseCase>(
      () => _i18.AddMarkerPointUseCase(get<_i12.MarkersRepositoryI>()));
  gh.factory<_i19.AuthDataSourceI>(() => _i19.AuthDataSourceImpl(
        firebaseAuth: get<_i4.FirebaseAuth>(),
        firestoreUsers: get<_i9.FirestoreUsers>(),
      ));
  gh.factory<_i20.AuthRepositoryI>(
      () => _i21.AuthRepositoryImplementation(get<_i19.AuthDataSourceI>()));
  gh.factory<_i22.AuthRepositoryI>(
      () => _i23.AuthRepositoryImpl(get<_i19.AuthDataSourceI>()));
  gh.factory<_i24.ChatsDatasourceI>(() => _i24.ChatsDatasourceImpl(
        firestoreChats: get<_i6.FirestoreChats>(),
        firestoreMessages: get<_i8.FirestoreMessages>(),
      ));
  gh.factory<_i25.ChatsRepositoryI>(
      () => _i26.ChatsRepositoryImpl(get<_i24.ChatsDatasourceI>()));
  gh.factory<_i27.GetChatMessagesUseCase>(
      () => _i27.GetChatMessagesUseCase(get<_i25.ChatsRepositoryI>()));
  gh.factory<_i28.GetMarkersUseCase>(
      () => _i28.GetMarkersUseCase(get<_i12.MarkersRepositoryI>()));
  gh.factory<_i29.GetUsersChatsUseCase>(
      () => _i29.GetUsersChatsUseCase(get<_i25.ChatsRepositoryI>()));
  gh.factory<_i30.JoinChatGroupUseCase>(
      () => _i30.JoinChatGroupUseCase(get<_i25.ChatsRepositoryI>()));
  gh.factory<_i31.LeaveChatGroupUseCase>(
      () => _i31.LeaveChatGroupUseCase(get<_i25.ChatsRepositoryI>()));
  gh.factory<_i32.MapCubit>(() => _i32.MapCubit(
        getMarkers: get<_i28.GetMarkersUseCase>(),
        joinChatGroup: get<_i30.JoinChatGroupUseCase>(),
      ));
  gh.factory<_i33.PickMarkerLocationCubit>(
      () => _i33.PickMarkerLocationCubit(get<_i18.AddMarkerPointUseCase>()));
  gh.factory<_i34.SendMessageUseCase>(
      () => _i34.SendMessageUseCase(get<_i25.ChatsRepositoryI>()));
  gh.factory<_i35.SignInUseCase>(
      () => _i35.SignInUseCase(get<_i22.AuthRepositoryI>()));
  gh.factory<_i36.SignOutUseCase>(
      () => _i36.SignOutUseCase(get<_i22.AuthRepositoryI>()));
  gh.factory<_i37.SignUpUseCase>(
      () => _i37.SignUpUseCase(get<_i22.AuthRepositoryI>()));
  gh.factory<_i38.AppStateCubit>(() => _i38.AppStateCubit(
        authRepository: get<_i20.AuthRepositoryI>(),
        firebaseAuth: get<_i4.FirebaseAuth>(),
      ));
  gh.factory<_i39.ChatsCubit>(
      () => _i39.ChatsCubit(get<_i29.GetUsersChatsUseCase>()));
  gh.factory<_i40.MessagesCubit>(() => _i40.MessagesCubit(
        get<_i27.GetChatMessagesUseCase>(),
        get<_i34.SendMessageUseCase>(),
        get<_i31.LeaveChatGroupUseCase>(),
      ));
  gh.factory<_i41.SignInCubit>(
      () => _i41.SignInCubit(get<_i35.SignInUseCase>()));
  gh.factory<_i42.SignUpCubit>(
      () => _i42.SignUpCubit(get<_i37.SignUpUseCase>()));
  return get;
}

class _$RegisterModule extends _i43.RegisterModule {}
