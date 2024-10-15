import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_hub/Modules/UISections/Oauth/ResetPassword/Views/ResetPasswordScreen.dart';
import 'package:movie_hub/Modules/UISections/Settings/Model/SettingItemEnum.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent.shade100, Colors.deepPurple.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            _buildSettingItem(
                context, SettingItem.profile, Icons.person_outline),
            _buildSettingItem(
                context, SettingItem.security, Icons.lock_outline),
            _buildSettingItem(
                context, SettingItem.theme, Icons.color_lens_outlined),
            _buildSettingItem(
                context, SettingItem.news, Icons.article_outlined),
            _buildSettingItem(
                context, SettingItem.resetPassword, Icons.lock_reset_outlined),
            _buildSettingItem(
                context, SettingItem.logout, Icons.logout_outlined),
            const Spacer(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(
      BuildContext context, SettingItem item, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.4),
      child: ListTile(
        leading: Icon(icon, color: Colors.white, size: 28),
        title: Text(
          item.getTitle(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        tileColor: Colors.deepPurple.withOpacity(0.8),
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
      default:
        break;
    }
  }
}
