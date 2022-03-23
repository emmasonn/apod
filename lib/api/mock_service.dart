import 'dart:convert';

import 'package:apod/api_model/apod.dart';
import 'package:flutter/services.dart';

class MockApodService {
  Future<List<Apod>> getFavoriteApods() async {
    final favoriteApods = getRecent();
    return favoriteApods;
  }

  Future<List<Apod>> getApods() async {
    final apods = _getApods();
    return apods;
  }

  Future<List<Apod>> getFavoriteApod(List<String> favoriteIds) async {
    final apods = _getFavoriteApod(favoriteIds);
    return apods;
  }

  Future<List<Apod>> getRecent() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final dataString = await _loadString('assets/json_files/favorite.json');
    final apodList = json.decode(dataString);
    List<Apod> favoriteApods = [];
    apodList.forEach((e) => favoriteApods.add(Apod.fromJson(e)));
    return favoriteApods;
  }

  Future<List<Apod>> _getFavoriteApod(List<String> favoriteIds) async {
    final apods = await _getApods();
    final recentApodIds = <String, Apod>{};
    for (final apod in apods) {
      recentApodIds[apod.id] = apod;
    }
    return favoriteIds.map<Apod>((id) => recentApodIds[id]!).toList();
  }

  Future<Apod> getSingleApod(String apodId) async {
    final apodList = await getApods();
    return apodList.firstWhere((element) => element.id == apodId);
  }

  Future<List<Apod>> _getApods() async {
    await Future.delayed(
      const Duration(milliseconds: 1000),
    );
    final dataString = await _loadString('assets/json_files/recent.json');
    final apodList = json.decode(dataString);
    List<Apod> apods = [];
    apodList.forEach((e) => apods.add(Apod.fromJson(e)));
    return apods;
  }

  Future<String> _loadString(String path) {
    return rootBundle.loadString(path);
  }
}
