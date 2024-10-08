enum TabItem { home, search, setting }

extension TabItemExtension on TabItem {
  String getTitle() {
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
