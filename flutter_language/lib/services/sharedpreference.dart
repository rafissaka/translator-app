import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService extends GetxService {
  late SharedPreferences _prefs;

  // Change the return type to Future<SharedPreferencesService>
  Future<SharedPreferencesService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this; // Return the instance of SharedPreferencesService
  }

  Future<void> addFavorite(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getFavorite(String key) {
    return _prefs.getString(key);
  }

  List<String> getAllFavorites() {
    return _prefs.getKeys().toList();
  }

  void clearAllFavorites() {
    // Clear all stored favorites from SharedPreferences
    _prefs.clear();
  }
}
