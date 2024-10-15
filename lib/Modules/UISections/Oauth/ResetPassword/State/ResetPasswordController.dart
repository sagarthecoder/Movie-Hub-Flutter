import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var isValid = false.obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    newPasswordController.addListener(_validatePassword);
    confirmPasswordController.addListener(_validatePassword);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _validatePassword() {
    String newPassword = newPasswordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    if (newPassword.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        _isValidPassword(newPassword) &&
        _isValidPassword(confirmPassword) &&
        newPassword == confirmPassword) {
      isValid.value = true;
    } else {
      isValid.value = false;
    }
  }

  bool _isValidPassword(String password) {
    return password.length > 6;
  }
}
