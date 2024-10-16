import 'dart:ui';

import 'package:get/get.dart';
import 'package:movie_hub/Helpers/AppConstants.dart';
import 'package:movie_hub/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  final languages = L10n.all;
  var selectedLanguageIndex = 0.obs;

  LanguageController() {
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedLanguageCode =
        await prefs.getString(AppConstants.selectedLocalizedLanguageCodeKey);
    print("Cached response ${cachedLanguageCode}");
    if (cachedLanguageCode == null) {
      return;
    }
    for (int i = 0; i < languages.length; i++) {
      if (languages[i].languageCode == cachedLanguageCode) {
        selectedLanguageIndex.value = i;
      }
    }
    print("pre Selected langugae = ${selectedLanguageIndex.value}");
  }

  Future<void> setNewLanguage(Locale locale) async {
    await addToDB(locale);
    int? matchedIndex = findMatchedLanguageIndex(locale);
    print("matchedIndex = $matchedIndex");
    if (matchedIndex != null) {
      selectedLanguageIndex.value = matchedIndex;
    }
  }

  Future<void> addToDB(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(
          AppConstants.selectedLocalizedLanguageCodeKey, locale.languageCode);
    } catch (err) {
      print("language error = ${err.toString()}");
    }
  }

  int? findMatchedLanguageIndex(Locale locale) {
    print("locale match given = ${locale.languageCode}");
    for (int i = 0; i < languages.length; i++) {
      if (languages[i].languageCode == locale.languageCode) {
        return i;
      }
    }
    return null;
  }
}
