import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart/sharedpreference_controller.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final FavoriteTranslationsController _controller = Get.find();

  void _clearFavorites() {
    _controller.clearFavorites();
    // Update the UI immediately after clearing favorites
    setState(() {});
  }

  // ignore: unused_element
  void _addFavorite() {
    // Add a favorite here
    _controller.addFavorite("key", "value");
    // Update the UI immediately after adding a favorite
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff003366),
        title: const Text(
          "My Favorites",
          style: TextStyle(color: Colors.white),
        ),
        actions: _controller.favorites.isNotEmpty
            ? [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: _clearFavorites,
                    child: const Text(
                      'Clear All',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ]
            : null,
      ),
      body: Obx(() => _controller.favorites.isNotEmpty
          ? ListView.builder(
              itemCount: _controller.favorites.length,
              itemBuilder: (context, index) {
                final key = _controller.favorites[index];
                final value = _controller.getFavorite(key);

                return ListTile(
                  title: Text(key),
                  subtitle: Text(value ?? ''),
                );
              },
            )
          : const Center(
              child: Text('No favorites added yet.'),
            )),
    );
  }
}
