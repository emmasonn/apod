import 'dart:convert';

import 'package:apod/api_model/apod.dart';
import 'package:flutter/services.dart';

class MockApodService {
  Future<List<Apod>> getFavoriteApods() async {
    final favoriteApods = _getFavoriteApods();
    return favoriteApods;
  }

  Future<List<Apod>> getApods() async {
    final apods = _getApods();
    return apods;
  }

  Future<List<Apod>> _getFavoriteApods() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final dataString = await _loadString('assets/json_files/favorite.json');
    final apodList = json.decode(dataString);
    List<Apod> favoriteApods = [];
    apodList.forEach((e) => favoriteApods.add(Apod.fromJson(e)));
    return favoriteApods;
  }

  Future<List<Apod>> _getApods() async {
    await Future.delayed(
      const Duration(milliseconds: 1000),
    );
    final dataString = await _loadString('assets/json_files/');
    final apodList = json.decode(dataString);
    List<Apod> apods = [];
    apodList.forEach((e) => apods.add(Apod.fromJson(e)));
    return apods;
  }

  Future<String> _loadString(String path) {
    return rootBundle.loadString(path);
  }
}
