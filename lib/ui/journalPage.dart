import 'package:apod/provider_model/journal_manager.dart';
import 'package:apod/provider_model/tab_manager.dart';
import 'package:apod/ui/emptyListView.dart';
import 'package:apod/ui/journal_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<JournalManager>(
        builder: (context, journalManager, child) {
          return (journalManager.entries.isEmpty)
              ? const EmptyJournalList()
              : const JournalScreen();
        },
      ),
    );
  }
}
