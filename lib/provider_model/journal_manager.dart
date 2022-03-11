import 'package:flutter/material.dart';

import '../domain/journal_model.dart';

class JournalManager extends ChangeNotifier {
  final List<Journal> _entries = [];
  List<Journal> getEntries() => _entries;

  void deleteItem(int index) {
    _entries.removeAt(index);
    notifyListeners();
  }

  void addItem(Journal item) {
    _entries.add(item);
    notifyListeners();
  }

  void updateItem(Journal item, int index) {
    _entries[index] = item;
    notifyListeners();
  }
}
