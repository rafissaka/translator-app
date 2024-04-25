import 'package:flutter/material.dart';
import 'package:flutter_language/controller.dart/sharedpreference_controller.dart';
import 'package:flutter_language/pages/splash.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'services/sharedpreference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the SharedPreferencesService
  await Get.putAsync(() => SharedPreferencesService().init(), permanent: true);

  // Initialize the FavoriteTranslationsController
  Get.put(FavoriteTranslationsController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme().apply(),
        ),
        home: const SplashPage());
  }
}
