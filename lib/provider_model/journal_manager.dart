import 'package:flutter/material.dart';

import '../domain/journal_model.dart';

class JournalManager extends ChangeNotifier {
  List<Journal>? _sortedEntries = <Journal>[];
  final Map<String, Journal> _byId = {};

  List<Journal> get entries {
    _sortedEntries ??= _byId.values.toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    return List.unmodifiable(_sortedEntries!);
  }

  Journal getItem(index) {
    return _byId[index]!;
  }

  void setItem(Journal journal) {
    _byId[journal.id] = journal;
    _sortedEntries = null;
    notifyListeners();
  }

  void removeJournal(Journal item) {
    _byId.remove(item.id);
    _sortedEntries = null;
    notifyListeners();
  }
}
