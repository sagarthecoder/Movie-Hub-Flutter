import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:movie_hub/Modules/UISections/CustomViews/Field/CustomTextField.dart';
import 'package:movie_hub/Modules/UISections/Oauth/Login/ViewModel/AuthViewModel.dart';
import 'package:movie_hub/Modules/UISections/Oauth/ResetPassword/State/ResetPasswordController.dart';

class ResetPasswordScreen extends StatelessWidget {
  final _controller = Get.put(ResetPasswordController());
  final _authViewModel = Get.put(AuthViewModel());

  ResetPasswordScreen({super.key}) {
    _authViewModel.isLoading.value = false;
    _authViewModel.resetPasswordSuccess.value = false;
    _authViewModel.errorText.value = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        automaticallyImplyLeading: true,
      ),
      body: Stack(
        children: [
          _buildContent(),
          _showLoaderIfNeeded(),
          _showErrorIfNeeded(),
          _showSuccessDialog(),
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

  Widget _showErrorIfNeeded() {
    return Obx(() {
      return _authViewModel.errorText.value.isNotEmpty
          ? Center(
              child: AlertDialog(
              backgroundColor: Colors.black,
              title: const Text(
                'Error',
                style: TextStyle(color: Colors.red),
              ),
              content: Text(
                _authViewModel.errorText.value,
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      _authViewModel.errorText.value = "";
                      Get.back();
                    },
                    child: const Text("Ok"))
              ],
            ))
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

  Widget _showSuccessDialog() {
    return Obx(() {
      if (_authViewModel.resetPasswordSuccess.value) {
        return Center(
            child: AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            'Success',
            style: TextStyle(color: Colors.green),
          ),
          content: const Text(
            'Password updated successfully',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                  _authViewModel.resetPasswordSuccess.value = false;
                },
                child: const Text("Ok"))
          ],
        ));
      } else {
        return Container();
      }
    });
  }

  void updatePassword() async {
    String newPassword = _controller.newPasswordController.text;
    if (newPassword.isNotEmpty) {
      _authViewModel.updatePassword(newPassword);
    }
  }
}
