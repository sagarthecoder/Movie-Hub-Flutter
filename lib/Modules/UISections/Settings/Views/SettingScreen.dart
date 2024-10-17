import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_hub/Modules/UISections/Oauth/Login/ViewModel/AuthViewModel.dart';
import 'package:movie_hub/Modules/UISections/Oauth/Login/Views/LoginScreen.dart';
import 'package:movie_hub/Modules/UISections/Oauth/ResetPassword/Views/ResetPasswordScreen.dart';
import 'package:movie_hub/Modules/UISections/Settings/Model/SettingItemEnum.dart';
import 'package:movie_hub/Modules/UISections/Preferences/Language/Views/LanguageView.dart';
import 'package:movie_hub/Modules/UISections/Theme/Views/ThemeSelectionScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends StatelessWidget {
  final _authViewModel = Get.put(AuthViewModel());

  SettingScreen({super.key}) {
    _authViewModel.isLoading.value = false;
    _authViewModel.logoutSuccess.value = false;
    _authViewModel.errorText.value = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings_tab_text),
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Stack(
        children: [
          _buildContent(context),
          _showLoaderIfNeeded(),
          _gotoRoot(),
        ],
      ),
    );
  }

  Widget _showLoaderIfNeeded() {
    return Obx(() {
      return _authViewModel.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Container();
    });
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.secondary.withOpacity(0.2),
            Theme.of(context).colorScheme.primary,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          _buildSettingItem(
              context, SettingItem.theme, Icons.color_lens_outlined),
          _buildSettingItem(context, SettingItem.language, Icons.language),
          _buildSettingItem(
              context, SettingItem.resetPassword, Icons.lock_reset_outlined),
          _buildSettingItem(context, SettingItem.profile, Icons.person_outline),
          _buildSettingItem(context, SettingItem.security, Icons.lock_outline),
          _buildSettingItem(context, SettingItem.logout, Icons.logout_outlined),
          const Spacer(),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
      BuildContext context, SettingItem item, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      shadowColor: Theme.of(context).shadowColor,
      child: ListTile(
        leading: Icon(icon,
            color: Theme.of(context).colorScheme.onSurface, size: 28),
        title: Text(
          item.getTitle(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        tileColor: Theme.of(context).colorScheme.surface.withOpacity(0.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: () {
          _handleItemTap(context, item);
        },
      ),
    );
  }

  Widget _buildFooter() {
    return const Column(
      children: [
        Divider(color: Colors.white54),
        Text(
          '© 2024 Movie-Hub',
          style: TextStyle(color: Colors.white54, fontSize: 14),
        ),
      ],
    );
  }

  void _handleItemTap(BuildContext context, SettingItem item) {
    switch (item) {
      case SettingItem.resetPassword:
        Get.to(() => ResetPasswordScreen());
        break;
      case SettingItem.language:
        Get.to(() => LanguageView());
      case SettingItem.logout:
        _authViewModel.logout();
      case SettingItem.theme:
        Get.to(() => ThemeSelectionScreen());
      default:
        break;
    }
  }

  Widget _gotoRoot() {
    return Obx(() {
      if (_authViewModel.logoutSuccess.value) {
        Future.microtask(() => Get.offAll(() => const LoginScreen()));
        return const SizedBox();
      } else {
        return Container();
      }
    });
  }
}
