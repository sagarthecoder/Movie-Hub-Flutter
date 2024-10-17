import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_hub/Modules/UISections/IntroPage/Views/IntroScreen.dart';
import 'package:get/get.dart';
import "package:flutter_localizations/flutter_localizations.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_hub/l10n/l10n.dart';

import 'Modules/UISections/Preferences/Language/Controller/LanguageController.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(LanguageController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final languageController = Get.put(LanguageController());
  final languageController = Get.find<LanguageController>();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // final languageController = Get.find<LanguageController>();
      print(
          "Rebuild locale = ${languageController.currentLocale.value.languageCode}");

      return GetMaterialApp(
        title: 'Movie Hub',
        debugShowCheckedModeBanner: false,
        supportedLocales: L10n.all,
        locale: languageController.currentLocale.value,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        navigatorKey: navigatorKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: IntroScreen(),
      );
    });
  }
}
