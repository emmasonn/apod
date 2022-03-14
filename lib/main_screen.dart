import 'package:apod/provider_model/app_state_manager.dart';
import 'package:apod/ui/apod_page.dart';
import 'package:apod/ui/favorite_page.dart';
import 'package:apod/ui/journalPage.dart';
import 'package:apod/ui/recent_page.dart';
import 'package:apod/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider_model/tab_manager.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MainScreen> createState() => _MainScreenState();

  static Page page({LocalKey? key}) {
    return MaterialPage<void>(
      key: key,
      child: const MainScreen(title: 'Apod'),
    );
  }
}

class _MainScreenState extends State<MainScreen> {
  final pages = <Widget>[
    const ApodsPage(),
    const RecentPage(),
    const FavoritePage(),
    const JournalPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(
      builder: (context, appStateManager, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              widget.title,
            ),
          ),
          body: SafeArea(
            child: IndexedStack(
              index: appStateManager.selectedTab,
              children: pages,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            currentIndex: appStateManager.selectedTab,
            onTap: appStateManager.goToPage,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.photo),
                label: 'Apod',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Recent',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: 'Journal',
              ),
            ],
          ),
        );
      },
    );
  }
}
