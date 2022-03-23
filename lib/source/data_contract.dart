abstract class DataModel {
  final String id;
  const DataModel({
    required this.id,
  });
}

abstract class DataContract<T extends DataModel> {
  Future<void> setItem(T obj);
  Future<T?> getItem(String id);
  Future<List<T>> getItems();
  Future<List<String>> getFavoriteIds();
  Future<void> setFavorite(String id, bool isFavorited);
  Future<void> toggleFavorite(String id);
}

abstract class Source<T extends DataModel> extends DataContract<T> {}
