import 'package:apod/source/data_contract.dart';

class Repository<T extends DataModel> extends DataContract<T> {
  Repository({
    required this.sourceList,
  });
  final List<Source<T>> sourceList;

  @override
  Future<List<String>> getFavoriteIds() async {
    List<String> favoriteIds = [];
    final emptySources = <Source<T>>[];
    for (final source in sourceList) {
      favoriteIds = await source.getFavoriteIds();
      if (favoriteIds.isEmpty) {
        emptySources.add(source);
      } else {
        break;
      }
    }

    if (favoriteIds.isNotEmpty && emptySources.isNotEmpty) {
      for (final source in emptySources) {
        for (final id in favoriteIds) {
          source.setFavorite(id, true);
        }
      }
    }

    return favoriteIds;
  }

  @override
  Future<T?> getItem(String id) async {
    final emptySources = <Source<T>>[];
    T? item;
    for (final source in sourceList) {
      item = await source.getItem(id);

      if (item == null) {
        emptySources.add(source);
      } else {
        break;
      }
    }

    if (item != null && emptySources.isNotEmpty) {
      for (final source in emptySources) {
        source.setItem(item);
      }
    }
    return item;
  }

  @override
  Future<List<T>> getItems() async {
    final emptySources = <Source<T>>[];
    List<T> items = [];

    for (final source in sourceList) {
      items = await source.getItems();

      if (items.isEmpty) {
        emptySources.add(source);
      } else {
        break;
      }
    }

    if (items.isNotEmpty && emptySources.isNotEmpty) {
      for (final source in sourceList) {
        for (final item in items) {
          source.setItem(item);
        }
      }
    }
    return items;
  }

  @override
  Future<void> setFavorite(String id, bool isFavorited) async {
    for (final source in sourceList) {
      source.setFavorite(id, isFavorited);
    }
  }

  @override
  Future<void> setItem(T obj) async {
    for (final source in sourceList) {
      source.setItem(obj);
    }
  }

  @override
  Future<void> toggleFavorite(String id) async {
    for (final source in sourceList) {
      source.toggleFavorite(id);
    }
  }
}
