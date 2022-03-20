import 'package:apod/util/sharedPreference.dart';
import 'package:flutter/widgets.dart';

class FavoriteManager extends ChangeNotifier {
  FavoriteManager(this._persistence) {
    _readFromPersistence();
  }

  final _storageKey = 'apod_favorites';
  final Set<int> _favoriteIds = <int>{};
  final Persistence _persistence;

  void _addFavorite(int id) {
    _favoriteIds.add(id);
    _syncToPersistence();
    notifyListeners();
  }

  void _syncToPersistence() {
    final _idsAsString =
        _favoriteIds.map<String>((int id) => id.toString()).join(',');
    _persistence.setKey(_storageKey, _idsAsString);
  }

  void _readFromPersistence() {
    final String? idsAsString = _persistence.getKey(_storageKey);
    if (idsAsString != null) {
      _favoriteIds.addAll(idsAsString.split(',').map((e) => int.parse(e)));
    }
  }

  void _removeFavorite(int id) {
    _favoriteIds.remove(id);
    _syncToPersistence();
    notifyListeners();
  }

  void toggleFavorite(int id) =>
      isFavorited(id) ? _removeFavorite(id) : _addFavorite(id);

  Set<int> get favoriteIds => _favoriteIds;

  bool isFavorited(int id) => favoriteIds.contains(id);
}
