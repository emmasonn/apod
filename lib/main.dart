import 'package:apod/main_screen.dart';
import 'package:apod/provider_model/app_state_manager.dart';
import 'package:apod/provider_model/favorite_manager.dart';
import 'package:apod/provider_model/journal_manager.dart';
import 'package:apod/router/go_router.dart';
import 'package:apod/styles/apod_theme.dart';
import 'package:apod/util/sharedPreference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPrefs;
void main() async {
  //this is required when you want to access platform channels.
  WidgetsFlutterBinding.ensureInitialized();
  appStateManager.initialized();
  sharedPrefs = await SharedPreferences.getInstance();
  runApp(const ApodApp());
}

class ApodApp extends StatelessWidget {
  const ApodApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => appStateManager),
        ChangeNotifierProvider(
            create: (context) =>
                FavoriteManager(SharedPreferencePersistence(sharedPrefs))),
        ChangeNotifierProvider(create: (context) => JournalManager())
      ],
      child: MaterialApp.router(
        title: 'Nasal Apod',
        theme: ApodTheme.light(),
        darkTheme: ApodTheme.dark(),
        debugShowCheckedModeBanner: false,
        routerDelegate: goRouter.routerDelegate,
        routeInformationParser: goRouter.routeInformationParser,
      ),
    );
  }
}
