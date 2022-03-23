import 'package:apod/source/repository.dart';
import 'package:flutter/widgets.dart';

import '../api_model/apod.dart';

class FavoriteManager extends ChangeNotifier {
  FavoriteManager(this._apodRepository);
  final Repository<Apod> _apodRepository;

  Future<List<Apod>> getFavouriteApods() async {
    final favApods = <Apod>[];
    final favourites = await favoriteIds;
    for (String id in favourites) {
      var apod = (await _apodRepository.getItem(id))!;
      favApods.add(apod);
    }
    return favApods;
  }

  Future<List<String>> get favoriteIds async =>
      _apodRepository.getFavoriteIds();

  Future<bool> isFavorited(String id) async => (await favoriteIds).contains(id);

  void toggleFavorite(String id) {
    _apodRepository.toggleFavorite(id);
    notifyListeners();
  }
}
