import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../services/sharedpreference.dart';

class FavoriteTranslationsController extends GetxController {
  final SharedPreferencesService _sharedPreferencesService = Get.find();
  RxList<String> favorites = <String>[].obs;
  RxBool hasFavorites = false.obs; // Track whether favorites list is empty

  @override
  void onInit() {
    super.onInit();
    favorites.value = _sharedPreferencesService.getAllFavorites().obs;
    updateHasFavorites(); // Call this function to update hasFavorites initially
  }

  void updateHasFavorites() {
    hasFavorites.value = favorites.isNotEmpty;
  }

  void addFavorite(String key, String value) {
    if (!favorites.contains(key)) {
      _sharedPreferencesService.addFavorite(key, value);
      favorites.add(key);
      if (kDebugMode) {
        print("New favorite added: $key");
      }
      if (kDebugMode) {
        print("Updated favorites list: $favorites");
      }
      update(); // Update the UI after adding a favorite
    } else {
      if (kDebugMode) {
        print("Favorite already exists: $key");
      }
    }
  }

  String? getFavorite(String key) {
    return _sharedPreferencesService.getFavorite(key);
  }

  List<String> getAllFavorites() {
    return favorites.toList();
  }

  void clearFavorites() {
    favorites.clear();
    updateHasFavorites(); // Update hasFavorites after clearing favorites
    _sharedPreferencesService.clearAllFavorites();
  }
}
