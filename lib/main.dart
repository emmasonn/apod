import 'package:apod/main_screen.dart';
import 'package:apod/provider_model/journal_manager.dart';
import 'package:apod/provider_model/tab_manager.dart';
import 'package:apod/styles/apod_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ApodApp());
}

class ApodApp extends StatelessWidget {
  const ApodApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TabManager()),
        ChangeNotifierProvider(create: (context) => JournalManager())
      ],
      child: MaterialApp(
        title: 'Nasal Apod',
        theme: ApodTheme.light(),
        darkTheme: ApodTheme.dark(),
        debugShowCheckedModeBanner: false,
        home: const MainScreen(title: 'Apod'),
        // home: ApodThumbnail(apod: SampleData.apods[0]),
        // home: SplashScreen()
      ),
    );
  }
}
