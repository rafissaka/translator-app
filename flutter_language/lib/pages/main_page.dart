import 'package:flutter/material.dart';
import 'package:flutter_language/pages/file_page.dart';
import 'package:flutter_language/pages/favorites_page.dart';
import 'package:flutter_language/pages/home_page.dart';
import 'package:flutter_language/pages/speech_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<PersistentTabConfig> _tabs() => [
        PersistentTabConfig(
          screen: const HomePage(),
          item: ItemConfig(
            icon: const Icon(Icons.home),
            title: "Home",
          ),
        ),
        PersistentTabConfig(
          screen: const ImagePage(),
          item: ItemConfig(
            icon: const Icon(Icons.camera),
            title: "Camera",
          ),
        ),
        PersistentTabConfig(
          screen: const SpeechPage(),
          item: ItemConfig(
            icon: const Icon(Icons.voice_chat),
            title: "Voice",
          ),
        ),
        PersistentTabConfig(
          screen: const FavoritesPage(),
          item: ItemConfig(
            icon: const Icon(Icons.favorite),
            title: "Favourite",
          ),
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 16.0), // Adjust the value as needed
      child: PersistentTabView(
        controller: PersistentTabController(initialIndex: 0),
        tabs: _tabs(),
        navBarBuilder: (navBarConfig) => Style1BottomNavBar(
          navBarConfig: navBarConfig,
        ),
      ),
    );
  }
}
