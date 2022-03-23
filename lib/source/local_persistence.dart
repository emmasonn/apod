import 'package:apod/source/data_contract.dart';
import 'package:hive/hive.dart';

class LocalPersistenceSource<T extends DataModel> extends Source<T> {
  LocalPersistenceSource({
    required this.fromJson,
    required this.toJson,
  });
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;

  //<String, T>
  late Box _itemsBox;
  //<String, bool> (value for bool is always true)
  late Box _favoritesBox;

  @override
  Future<List<String>> getFavoriteIds() async =>
      _favoritesBox.keys.cast<String>().toList();

  Future<void> ready() async {
    _itemsBox = await Hive.openBox('${T.runtimeType.toString()}-items');
    _favoritesBox =
        await Hive.openBox('${T.runtimeType.toString()}-favorites}');
  }

  @override
  Future<T?> getItem(String id) async =>
      fromJson(_itemsBox.get(id).cast<String, dynamic>());

  @override
  Future<List<T>> getItems() async =>
      _itemsBox.values.map<T>((data) => fromJson(data)).toList();

  @override
  Future<void> setFavorite(String id, bool isFavorited) async =>
      isFavorited ? _favoritesBox.delete(id) : _favoritesBox.put(id, true);

  @override
  Future<void> setItem(T obj) async => _itemsBox.put(
        obj.id,
        toJson(obj),
      );

  @override
  Future<void> toggleFavorite(String id) => _favoritesBox.containsKey(id)
      ? _favoritesBox.delete(id)
      : _favoritesBox.put(id, true);
}
