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
    final manager = Provider.of<JournalManager>(context, listen: false);

    return Scaffold(
      body: Consumer<JournalManager>(builder: (context, journalManager, child) {
        final entries = journalManager.getEntries();
        return ListView.separated(
          itemCount: entries.length,
          itemBuilder: (context, index) {
            final item = entries[index];
            return Builder(builder: (context) {
              return Dismissible(
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
                  manager.deleteItem(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${item.title} dismissed'),
                    ),
                  );
                },
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddJournalEntry(
                          entry: item,
                          onCreate: (newItem) {},
                          onUpdate: (newItem) {
                            print('updateditem: $newItem');
                            manager.updateItem(newItem, index);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
                  child: JournalCard(key: Key(item.id), journal: item),
                ),
              );
            });
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddJournalEntry(
                onCreate: (item) {
                  manager.addItem(item);
                  Navigator.pop(context);
                },
                onUpdate: (item) {},
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
