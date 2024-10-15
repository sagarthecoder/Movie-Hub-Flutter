enum SettingItem { profile, security, theme, news, resetPassword, logout }

extension SettingItemExtension on SettingItem {
  String getTitle() {
    switch (this) {
      case SettingItem.profile:
        return "Profile";
      case SettingItem.security:
        return "Security";
      case SettingItem.theme:
        return "Theme";
      case SettingItem.news:
        return "News";
      case SettingItem.resetPassword:
        return "Reset password";
      case SettingItem.logout:
        return "Logout";
    }
  }
}
