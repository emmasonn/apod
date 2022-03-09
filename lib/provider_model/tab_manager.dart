import 'package:flutter/widgets.dart';

class TabManager extends ChangeNotifier {
  int selectedTab = 0;

  void goToPage(int index) {
    selectedTab = index;
    notifyListeners();
  }

  void goToRecent() {
    selectedTab = 0;
    notifyListeners();
  }
}
