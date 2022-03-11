import 'package:apod/cards/journal_card.dart';
import 'package:apod/provider_model/journal_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AddJournalEntry.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({Key? key}) : super(key: key);

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<JournalManager>(builder: (context, journalManager, child) {
        final entries = journalManager.getEntries();
        return ListView.builder(
          itemCount: entries.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddJournalEntry(
                      entry: entries[index],
                      onSave: (item) {
                        Provider.of<JournalManager>(context, listen: false)
                            .addItem(item);
                        Navigator.pop(context);
                      }),
                ),
              ),
              child: JournalCard(journal: entries[index]),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddJournalEntry(onSave: (item) {
                Provider.of<JournalManager>(context, listen: false)
                    .addItem(item);
                Navigator.pop(context);
              }),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
