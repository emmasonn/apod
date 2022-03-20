import 'package:apod/main_screen.dart';
import 'package:apod/provider_model/journal_manager.dart';
import 'package:apod/ui/AddJournalEntry.dart';
import 'package:apod/ui/ApodDetail.dart';
import 'package:apod/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../domain/journal_model.dart';

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
        apodDetail,
        editJournal,
      ]);

  static final apodDetail = GoRoute(
      name: 'apodDetail',
      path: 'apod/:id',
      pageBuilder: (BuildContext context, GoRouterState state) {
        final argument = int.parse(state.params['id']!);
        return ApodDetail.page(
          key: state.pageKey,
          apodId: argument,
        );
      });

  static final editJournal = GoRoute(
      name: 'editJournal',
      path: 'journal/:jid',
      pageBuilder: (BuildContext context, GoRouterState state) {
        final journalManager =
            Provider.of<JournalManager>(context, listen: false);
        final argument = state.params['jid']!;

        if (argument == 'add') {
          return AddJournalEntry.page(
            entry: null,
            onSave: journalManager.setItem,
          );
        }
        return AddJournalEntry.page(
          entry: journalManager.getItem(state.params['jid']!),
          onSave: journalManager.setItem,
        );
      });
}
