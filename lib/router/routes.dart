import 'package:apod/main_screen.dart';
import 'package:apod/provider_model/journal_manager.dart';
import 'package:apod/ui/AddJournalEntry.dart';
import 'package:apod/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Routes {
  static final splash = GoRoute(
    path: '/splash',
    pageBuilder: (BuildContext context, GoRouterState state) =>
        SplashPage.page(key: state.pageKey),
  );

  static final main = GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) =>
          MainScreen.page(
            key: state.pageKey,
          ),
      routes: [
        addJournal,
        editJournal,
      ]);

  static final addJournal = GoRoute(
      name: 'addJournal',
      path: 'journal-add',
      pageBuilder: (BuildContext context, GoRouterState state) {
        final journalManager =
            Provider.of<JournalManager>(context, listen: false);

        return AddJournalEntry.page();
      });

  static final editJournal = GoRoute(
      name: 'editJournal',
      path: 'journal-add',
      pageBuilder: (BuildContext context, GoRouterState state) {});
}
