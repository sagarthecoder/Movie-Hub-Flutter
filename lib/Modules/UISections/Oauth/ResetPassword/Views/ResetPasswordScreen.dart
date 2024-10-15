import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:movie_hub/Helpers/MathHelper.dart';
import 'package:movie_hub/Modules/Service/AuthService/AuthService.dart';
import 'package:movie_hub/Modules/UISections/CustomViews/Field/CustomTextField.dart';
import 'package:movie_hub/Modules/UISections/Oauth/ResetPassword/State/ResetPasswordController.dart';

class ResetPasswordScreen extends StatelessWidget {
  final _controller = Get.put(ResetPasswordController());
  ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildContent(),
          _showLoaderIfNeeded(),
        ],
      ),
    );
  }

  Widget _showLoaderIfNeeded() {
    return Obx(() {
      return _controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Container();
    });
  }

  Widget _buildContent() {
    return Container(
      margin: const EdgeInsets.only(top: 60, left: 26, right: 26),
      child: Column(
        children: [
          _setImage(),
          const SizedBox(
            height: 40,
          ),
          _addTitleDescription(),
          const SizedBox(
            height: 45,
          ),
          _buildTextFields(),
          const SizedBox(
            height: 30,
          ),
          _passwordActionButton(),
        ],
      ),
    );
  }

  Widget _setImage() {
    return Container(
      width: 220,
      height: 220 * 1.03743,
      alignment: Alignment.topCenter,
      child: Image.asset(
        "utils/images/update-password-thumb.png",
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget _addTitleDescription() {
    return const Column(
      children: [
        Text(
          "Enter New Password",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          "Set complex password to protect",
          style: TextStyle(
              color: Color(0XFF7F909F),
              fontWeight: FontWeight.normal,
              fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildTextFields() {
    return Column(
      children: [
        CustomTextField(
          controller: _controller.newPasswordController,
          labelText: "New Password",
          placeholder: "Enter new password",
          isObscureText: true,
        ),
        const SizedBox(
          height: 30,
        ),
        CustomTextField(
          controller: _controller.confirmPasswordController,
          labelText: "Confirm Password",
          placeholder: "Re-enter password",
          isObscureText: true,
        ),
      ],
    );
  }

  Widget _passwordActionButton() {
    return Obx(() {
      return Opacity(
        opacity: (_controller.isValid.value) ? 1.0 : 0.7,
        child: SizedBox(
          width: double.infinity,
          height: 56.0,
          child: ElevatedButton(
            onPressed: (_controller.isValid.value)
                ? () {
                    updatePassword();
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0XFFD70404),
            ),
            child: const Text(
              'Set New Password',
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

  void updatePassword() async {
    String password = _controller.newPasswordController.text;
    _controller.isLoading.value = true;
    if (password.isNotEmpty) {
      try {
        final result = await AuthService.shared.updatePassword(password);
        _controller.isLoading.value = false;
        Get.back();
      } catch (err) {
        print("failed to reset password = ${err.toString()}");
        _controller.isLoading.value = false;
      }
    }
  }
}
