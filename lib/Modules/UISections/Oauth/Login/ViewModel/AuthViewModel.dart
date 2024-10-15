import 'package:get/get.dart';

import '../../../../Service/AuthService/AuthService.dart';
import '../Model/OauthEnums.dart';

class AuthViewModel extends GetxController {
  var isLoading = false.obs;
  var signupSuccess = false.obs;
  var loginSuccess = false.obs;
  var logoutSuccess = false.obs;
  var resetPasswordSuccess = false.obs;
  var errorText = "".obs;

  Future<void> socialSignin(SocialSignInProvider provider) async {
    this.loginSuccess.value = false;
    switch (provider) {
      case SocialSignInProvider.google:
        try {
          await AuthService.shared.signInWithGoogle();
          this.loginSuccess.value = true;
        } catch (err) {
          errorText.value = err.toString();
          print("Error google signin = ${err.toString()}");
        }
      default:
        break;
    }
  }

  Future<void> loginWithEmail(String email, String password) async {
    loginSuccess.value = false;
    errorText.value = "";
    isLoading.value = true;
    try {
      await AuthService.shared.signInWithEmail(email, password);
      this.loginSuccess.value = true;
    } catch (err) {
      errorText.value = err.toString();
    }
    isLoading.value = false;
  }

  void updatePassword(String newPassword) async {
    isLoading.value = true;
    errorText.value = "";
    resetPasswordSuccess.value = false;
    if (newPassword.isNotEmpty) {
      try {
        final _ = await AuthService.shared.updatePassword(newPassword);
        resetPasswordSuccess.value = true;
      } catch (err) {
        errorText.value = err.toString();
        print("failed to reset password = ${err.toString()}");
      }
    }
    isLoading.value = false;
  }

  void logout() async {
    isLoading.value = true;
    errorText.value = "";
    logoutSuccess.value = false;
    try {
      await AuthService.shared.logout();
      logoutSuccess.value = true;
    } catch (err) {
      print("Logout Error = ${err.toString()}");
      errorText.value = err.toString();
    }
    isLoading.value = false;
  }
}
