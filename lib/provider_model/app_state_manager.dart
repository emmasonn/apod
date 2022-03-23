import 'dart:async';

import 'package:flutter/material.dart';

class ApodTab {
  static const int today = 0;
  static const int recent = 1;
  static const int favorites = 2;
  static const int journal = 3;
}

class AppStateManager extends ChangeNotifier {
  bool _initialized = false;
  bool _loggedIn = false;
  int _selectedTab = ApodTab.today;

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  int get selectedTab => _selectedTab;

  void logIn() {
    _loggedIn = true;
    notifyListeners();
  }

  void initializedApp() {
    Timer(const Duration(milliseconds: 2000), () {
      _initialized = true;
      notifyListeners();
    });
  }

  void goToPage(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  void setTabSilently(int index) {
    _selectedTab = index;
  }

  void goToRecent() {
    _selectedTab = ApodTab.recent;
    notifyListeners();
  }
}

final appStateManager = AppStateManager();
