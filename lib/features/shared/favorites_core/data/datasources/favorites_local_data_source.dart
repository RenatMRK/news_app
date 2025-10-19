import 'dart:convert';
import 'package:news_app/core/storage/i_local_storage.dart';

abstract class IFavoritesLocalDataSource {
  Future<List<Map<String, dynamic>>> getFavoritesRaw();
  Future<void> saveFavoritesRaw(List<Map<String, dynamic>> list);
}

class FavoritesLocalDataSourceImpl implements IFavoritesLocalDataSource {
  static const _key = 'favorites_articles';
  final ILocalStorage storage;

  FavoritesLocalDataSourceImpl(this.storage);

  @override
  Future<List<Map<String, dynamic>>> getFavoritesRaw() async {
    final jsonList = await storage.getStringList(_key) ?? [];
    return jsonList.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
  }

  @override
  Future<void> saveFavoritesRaw(List<Map<String, dynamic>> list) async {
    final jsonList = list.map((e) => jsonEncode(e)).toList();
    await storage.setStringList(_key, jsonList);
  }
}
