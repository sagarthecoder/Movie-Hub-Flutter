import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_hub/Modules/UISections/CustomViews/Field/CustomTextField.dart';
import 'package:movie_hub/Modules/UISections/Oauth/Login/ViewModel/AuthViewModel.dart';
import 'package:movie_hub/Modules/UISections/Oauth/Login/Views/LoginScreen.dart';
import 'package:movie_hub/Modules/UISections/Oauth/ResetPassword/State/ResetPasswordController.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordView extends StatelessWidget {
  final _controller = Get.put(ResetPasswordController());
  final _authViewModel = Get.put(AuthViewModel());

  ForgetPasswordView({super.key}) {
    _controller.isLoading.value = false;
    _controller.isValidEmail.value = false;
    _authViewModel.isSentResetPasswordEmail.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Stack(
        children: [
          _buildContent(context),
          _showLoadingIfNeeded(),
          _buildSuccessAlert(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField(
              controller: _controller.emailController,
              placeholder:
                  AppLocalizations.of(context)!.email_text_field_placeholder,
              labelText: AppLocalizations.of(context)!.email_text_field_label,
            ),
            const SizedBox(
              height: 20,
            ),
            _forgotPasswordActionButton(context),
          ],
        ),
      ),
    );
  }

  Widget _showLoadingIfNeeded() {
    return Obx(() {
      if (_authViewModel.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Container();
      }
    });
  }

  Widget _buildSuccessAlert(BuildContext context) {
    return Obx(() {
      if (_authViewModel.isSentResetPasswordEmail.value) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: Text(
            AppLocalizations.of(context)!.check_your_email_text,
            style: const TextStyle(color: Colors.green),
          ),
          content: Text(
            '${AppLocalizations.of(context)!.password_reset_link_email_description} ${_controller.emailController.text}',
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Get.offAll(() => const LoginScreen());
                  _authViewModel.isSentResetPasswordEmail.value = false;
                },
                child: Text(
                  AppLocalizations.of(context)!.got_it,
                  style: const TextStyle(color: Colors.pink, fontSize: 16),
                ))
          ],
        );
      } else {
        return Container();
      }
    });
  }

  Widget _forgotPasswordActionButton(BuildContext context) {
    return Obx(() {
      return Opacity(
        opacity: (_controller.isValidEmail.value) ? 1.0 : 0.7,
        child: SizedBox(
          width: double.infinity,
          height: 56.0,
          child: ElevatedButton(
            onPressed: (_controller.isValidEmail.value)
                ? () {
                    _authViewModel.forgetPassword(
                        _controller.emailController.text.trim());
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0XFFD70404),
            ),
            child: Text(
              AppLocalizations.of(context)!.reset_password_text,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
        ),
      );
    });
  }
}
