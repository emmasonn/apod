import 'package:apod/cards/journal_card.dart';
import 'package:apod/provider_model/journal_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    final manager = Provider.of<JournalManager>(context, listen: false);

    return Scaffold(
      body: Consumer<JournalManager>(builder: (context, journalManager, child) {
        final entries = journalManager.entries;
        return ListView.separated(
          itemCount: entries.length,
          itemBuilder: (context, index) {
            final item = entries[index];
            return GestureDetector(
              onTap: () => context.go('/journal/${item.id}'),
              child: Dismissible(
                key: Key(item.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: const Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
                onDismissed: (direction) {
                  manager.removeJournal(item);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item.title} dismissed'),
                    ),
                  );
                },
                child: JournalCard(key: Key(item.id), journal: item),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              thickness: 0.5,
              color: Colors.black54,
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/journal/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
