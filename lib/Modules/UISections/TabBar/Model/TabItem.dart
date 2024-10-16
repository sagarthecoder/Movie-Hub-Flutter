import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../main.dart';

enum TabItem { home, search, setting }

extension TabItemExtension on TabItem {
  String getTitle() {
    final context = navigatorKey.currentState?.overlay?.context;
    if (context == null) {
      return getFallbackTitle();
    }
    switch (this) {
      case TabItem.home:
        String localizedText =
            AppLocalizations.of(context)?.home_tab_text ?? "Home";
        return localizedText;
      case TabItem.search:
        String localizedText =
            AppLocalizations.of(context)?.search_tab_text ?? "Search";
        return localizedText;
      case TabItem.setting:
        String localizedText =
            AppLocalizations.of(context)?.settings_tab_text ?? "Settings";
        return localizedText;
    }
  }

  String getFallbackTitle() {
    switch (this) {
      case TabItem.home:
        return "Home";
      case TabItem.search:
        return "Search";
      case TabItem.setting:
        return "Settings";
    }
  }
}
