import 'package:apod/provider_model/app_state_manager.dart';
import 'package:apod/provider_model/journal_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'AddJournalEntry.dart';

class EmptyJournalList extends StatefulWidget {
  const EmptyJournalList({Key? key}) : super(key: key);

  @override
  State<EmptyJournalList> createState() => _EmptyJournalListState();
}

class _EmptyJournalListState extends State<EmptyJournalList> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appStateManager =
        Provider.of<AppStateManager>(context, listen: false);
    final journalManager = Provider.of<JournalManager>(context, listen: false);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/journal/add'),
        // {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => AddJournalEntry(
        //         onCreate: (item) {
        //           journalManager.addItem(item);
        //           Navigator.pop(context);
        //         },
        //         onUpdate: (item) {},
        //       ),
        //     ),
        //   );
        // }
        child: const Icon(
          Icons.add,
          // color: Colors.white,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: (size.height / 30),
          ),
          SizedBox(
            width: (size.width / 2),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                  'assets/apod_images/2021-10-07-NGC6559Sartori1024.jpeg'),
            ),
          ),
          SizedBox(
            height: (size.height / 30),
          ),
          Text(
            'No Journal Entries',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(height: size.height / 30),
          Text(
            'Tap the Edit buttom to create entry',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            height: size.height / 30,
          ),
          Center(
            child: MaterialButton(
              onPressed: () {
                appStateManager.goToRecent();
              },
              // padding: const EdgeInsets.all(20.0),
              child: const Text(
                'Browse Apods',
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Theme.of(context).colorScheme.primary,
              textColor: Colors.white,
            ),
          ),
          SizedBox(height: size.height / 30)
        ],
      ),
    );
  }
}
