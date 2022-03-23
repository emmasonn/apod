import 'package:apod/api/mock_service.dart';
import 'package:apod/api_model/apod.dart';
import 'package:apod/provider_model/manager_model.dart';
import 'package:apod/router/go_router.dart';
import 'package:apod/source/source_model.dart';
import 'package:apod/styles/apod_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

// late SharedPreferences sharedPref;
late Repository<Apod> apodRepository;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  appStateManager.initializedApp();

  Hive.initFlutter();
  final apodHive = LocalPersistenceSource(
    fromJson: (Map<String, dynamic> json) => Apod.fromJson(json),
    toJson: (Apod obj) => obj.toJson(),
  );

  await apodHive.ready();

  // sharedPref = await SharedPreferences.getInstance();
  apodRepository = Repository<Apod>(
    sourceList: [LocalMemorySource<Apod>(), apodHive],
  );
  final apodService = MockApodService();
  (await apodService.getRecent()).forEach(apodRepository.setItem);
  runApp(const ApodApp());
}

class ApodApp extends StatelessWidget {
  const ApodApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appStateManager),
        ChangeNotifierProvider(
            create: (context) => FavoriteManager(apodRepository)),
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
