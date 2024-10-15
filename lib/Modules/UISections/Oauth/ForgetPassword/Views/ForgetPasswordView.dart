import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_hub/Modules/UISections/CustomViews/Field/CustomTextField.dart';
import 'package:movie_hub/Modules/UISections/Oauth/Login/ViewModel/AuthViewModel.dart';
import 'package:movie_hub/Modules/UISections/Oauth/Login/Views/LoginScreen.dart';
import 'package:movie_hub/Modules/UISections/Oauth/ResetPassword/State/ResetPasswordController.dart';

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
          _buildContent(),
          _showLoadingIfNeeded(),
          _buildSuccessAlert(),
        ],
      ),
    );
  }

  Widget _buildContent() {
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
              placeholder: 'Enter email',
              labelText: "Email",
            ),
            const SizedBox(
              height: 20,
            ),
            _forgotPasswordActionButton(),
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

  Widget _buildSuccessAlert() {
    return Obx(() {
      if (_authViewModel.isSentResetPasswordEmail.value) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: const Text(
            "Check your email",
            style: TextStyle(color: Colors.green),
          ),
          content: Text(
            'Password reset link has been sent to ${_controller.emailController.text}',
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Get.offAll(() => const LoginScreen());
                  _authViewModel.isSentResetPasswordEmail.value = false;
                },
                child: const Text(
                  "Got it",
                  style: TextStyle(color: Colors.pink, fontSize: 16),
                ))
          ],
        );
      } else {
        return Container();
      }
    });
  }

  Widget _forgotPasswordActionButton() {
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
            child: const Text(
              'Reset Password',
              style: TextStyle(
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
