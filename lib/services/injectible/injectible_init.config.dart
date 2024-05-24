// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:connectivity_plus/connectivity_plus.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i11;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i15;
import 'package:shared_preferences/shared_preferences.dart' as _i16;

import '../../auth/datasource/auth_datasource.dart' as _i20;
import '../../auth/repository/auth_repo.dart' as _i21;
import '../../auth/repository/auth_repo_impl.dart' as _i22;
import '../../domain/auth/datasource/auth_datasource.dart' as _i19;
import '../../domain/auth/repository/auth_repo.dart' as _i23;
import '../../domain/auth/repository/auth_repo_impl.dart' as _i24;
import '../../flows/auth/data/repositories/auth_repository_impl.dart' as _i26;
import '../../flows/auth/domain/repositories/auth_repository.dart' as _i25;
import '../../flows/auth/domain/usecases/sign_in.dart' as _i36;
import '../../flows/auth/domain/usecases/sign_out.dart' as _i37;
import '../../flows/auth/domain/usecases/sign_up.dart' as _i38;
import '../../flows/auth/presentation/pages/sign_in/cubit/sign_in_cubit.dart'
    as _i42;
import '../../flows/auth/presentation/pages/sign_up/cubit/sign_up_cubit.dart'
    as _i43;
import '../../flows/main/data/datasources/chats_datasource.dart' as _i27;
import '../../flows/main/data/repositories/chats_repository_impl.dart' as _i29;
import '../../flows/main/domain/repositories/chats_repository.dart' as _i28;
import '../../flows/main/domain/usecases/get_chat_messages.dart' as _i30;
import '../../flows/main/domain/usecases/get_users_chats.dart' as _i32;
import '../../flows/main/domain/usecases/join_chat_group.dart' as _i33;
import '../../flows/main/domain/usecases/send_message.dart' as _i35;
import '../../flows/main/presentation/pages/chat_page/cubit/messages_cubit.dart'
    as _i41;
import '../../flows/main/presentation/pages/main/cubit/chats_cubit.dart'
    as _i40;
import '../../flows/menu/data/datasources/markers_datasource.dart' as _i12;
import '../../flows/menu/data/repositories/markers_repository_impl.dart'
    as _i14;
import '../../flows/menu/domain/repositories/markers_repository.dart' as _i13;
import '../../flows/menu/domain/usecases/get_markers.dart' as _i31;
import '../../flows/menu/presentation/pages/spots_map/cubit/map_cubit.dart'
    as _i34;
import '../../flows/splash/presentation/pages/splash/cubit/splash_cubit.dart'
    as _i17;
import '../../navigation/app_state_cubit/app_state_cubit.dart' as _i39;
import '../../themes/theme_data_values.dart' as _i18;
import '../app_intenal_notification_system/bloc/app_intenal_notifications_bloc.dart'
    as _i3;
import '../firestore/firestore_chats.dart' as _i7;
import '../firestore/firestore_markers.dart' as _i8;
import '../firestore/firestore_messages.dart' as _i9;
import '../firestore/firestore_users.dart' as _i10;
import 'injectible_init.dart' as _i44; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i3.AppInternalNotificationsBloc>(
      () => _i3.AppInternalNotificationsBloc());
  gh.lazySingleton<_i4.Connectivity>(() => registerModule.connectivity);
  gh.lazySingleton<_i5.FirebaseAuth>(() => registerModule.firebaseAuth);
  gh.lazySingleton<_i6.FirebaseFirestore>(() => registerModule.firestore);
  gh.factory<_i7.FirestoreChats>(
      () => _i7.FirestoreChats(get<_i6.FirebaseFirestore>()));
  gh.factory<_i8.FirestoreMarkers>(
      () => _i8.FirestoreMarkers(get<_i6.FirebaseFirestore>()));
  gh.factory<_i9.FirestoreMessages>(
      () => _i9.FirestoreMessages(get<_i6.FirebaseFirestore>()));
  gh.factory<_i10.FirestoreUsers>(
      () => _i10.FirestoreUsers(get<_i6.FirebaseFirestore>()));
  gh.lazySingleton<_i11.FlutterSecureStorage>(
      () => registerModule.flutterSecureStorage);
  gh.factory<_i12.MarkersDatasourceI>(() => _i12.MarkersDatasourceImpl(
      firestoreMarkers: get<_i8.FirestoreMarkers>()));
  gh.factory<_i13.MarkersRepositoryI>(
      () => _i14.MarkersRepositoryImpl(get<_i12.MarkersDatasourceI>()));
  await gh.factoryAsync<_i15.PackageInfo>(
    () => registerModule.packageInfo,
    preResolve: true,
  );
  await gh.factoryAsync<_i16.SharedPreferences>(
    () => registerModule.prefs,
    preResolve: true,
  );
  gh.factory<_i17.SplashCubit>(() => _i17.SplashCubit());
  gh.lazySingleton<_i18.ThemeDataValues>(() => _i18.ThemeDataValues());
  gh.factory<_i19.AuthDataSourceI>(() => _i19.AuthDataSourceImpl(
        firebaseAuth: get<_i5.FirebaseAuth>(),
        firestoreUsers: get<_i10.FirestoreUsers>(),
      ));
  gh.factory<_i20.AuthDataSourceI>(() => _i20.AuthDataSourceImpl(
        firebaseAuth: get<_i5.FirebaseAuth>(),
        firestoreUsers: get<_i10.FirestoreUsers>(),
      ));
  gh.factory<_i21.AuthRepositoryI>(
      () => _i22.AuthRepositoryImplementation(get<_i19.AuthDataSourceI>()));
  gh.factory<_i23.AuthRepositoryI>(
      () => _i24.AuthRepositoryImplementation(get<_i19.AuthDataSourceI>()));
  gh.factory<_i25.AuthRepositoryI>(
      () => _i26.AuthRepositoryImpl(get<_i19.AuthDataSourceI>()));
  gh.factory<_i27.ChatsDatasourceI>(() => _i27.ChatsDatasourceImpl(
        firestoreChats: get<_i7.FirestoreChats>(),
        firestoreMessages: get<_i9.FirestoreMessages>(),
      ));
  gh.factory<_i28.ChatsRepositoryI>(
      () => _i29.ChatsRepositoryImpl(get<_i27.ChatsDatasourceI>()));
  gh.factory<_i30.GetChatMessagesUseCase>(
      () => _i30.GetChatMessagesUseCase(get<_i28.ChatsRepositoryI>()));
  gh.factory<_i31.GetMarkersUseCase>(
      () => _i31.GetMarkersUseCase(get<_i13.MarkersRepositoryI>()));
  gh.factory<_i32.GetUsersChatsUseCase>(
      () => _i32.GetUsersChatsUseCase(get<_i28.ChatsRepositoryI>()));
  gh.factory<_i33.JoinChatGroupUseCase>(
      () => _i33.JoinChatGroupUseCase(get<_i28.ChatsRepositoryI>()));
  gh.factory<_i34.MapCubit>(() => _i34.MapCubit(
        getMarkers: get<_i31.GetMarkersUseCase>(),
        joinChatGroup: get<_i33.JoinChatGroupUseCase>(),
      ));
  gh.factory<_i35.SendMessageUseCase>(
      () => _i35.SendMessageUseCase(get<_i28.ChatsRepositoryI>()));
  gh.factory<_i36.SignInUseCase>(
      () => _i36.SignInUseCase(get<_i25.AuthRepositoryI>()));
  gh.factory<_i37.SignOutUseCase>(
      () => _i37.SignOutUseCase(get<_i25.AuthRepositoryI>()));
  gh.factory<_i38.SignUpUseCase>(
      () => _i38.SignUpUseCase(get<_i25.AuthRepositoryI>()));
  gh.factory<_i39.AppStateCubit>(() => _i39.AppStateCubit(
        authRepository: get<_i23.AuthRepositoryI>(),
        firebaseAuth: get<_i5.FirebaseAuth>(),
      ));
  gh.factory<_i40.ChatsCubit>(
      () => _i40.ChatsCubit(get<_i32.GetUsersChatsUseCase>()));
  gh.factory<_i41.MessagesCubit>(() => _i41.MessagesCubit(
        get<_i30.GetChatMessagesUseCase>(),
        get<_i35.SendMessageUseCase>(),
      ));
  gh.factory<_i42.SignInCubit>(
      () => _i42.SignInCubit(get<_i36.SignInUseCase>()));
  gh.factory<_i43.SignUpCubit>(
      () => _i43.SignUpCubit(get<_i38.SignUpUseCase>()));
  return get;
}

class _$RegisterModule extends _i44.RegisterModule {}
