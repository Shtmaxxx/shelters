import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shelters/themes/theme_data_values.dart';

import 'navigation/app_state_cubit/app_state_cubit.dart';
import 'navigation/helpers/title_observer.dart';
import 'services/injectible/injectible_init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Routemaster.setPathUrlStrategy();
  await configureDependencies();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(App());
}

class App extends StatelessWidget {
  final AppStateCubit appStateCubit;

  App({super.key}) : appStateCubit = getIt<AppStateCubit>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: appStateCubit,
        ),
      ],
      child: BlocBuilder<AppStateCubit, AppState>(
        bloc: appStateCubit,
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: getIt<ThemeDataValues>().defaultThemeData,
            themeMode: ThemeMode.system,
            routeInformationParser: const RoutemasterParser(),
            routerDelegate: RoutemasterDelegate(
              observers: [
                TitleObserver(),
              ],
              routesBuilder: (context) => state.routeMap,
            ),
          );
        },
      ),
    );
  }
}
