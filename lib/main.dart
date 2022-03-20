import 'package:apod/main_screen.dart';
import 'package:apod/provider_model/app_state_manager.dart';
import 'package:apod/provider_model/journal_manager.dart';
import 'package:apod/router/go_router.dart';
import 'package:apod/source/repository.dart';
import 'package:apod/styles/apod_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

late  sharedPref;
late Repository apodRepository;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  appStateManager.initialized();
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
