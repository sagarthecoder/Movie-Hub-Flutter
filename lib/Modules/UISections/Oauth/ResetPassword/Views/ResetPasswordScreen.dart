import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_hub/Modules/UISections/CustomViews/Field/CustomTextField.dart';
import 'package:movie_hub/Modules/UISections/Oauth/Login/ViewModel/AuthViewModel.dart';
import 'package:movie_hub/Modules/UISections/Oauth/ResetPassword/State/ResetPasswordController.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        title: Text(
          AppLocalizations.of(context)!.reset_password_text,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: true,
      ),
      body: Stack(
        children: [
          _buildContent(context),
          _showLoaderIfNeeded(),
          _showErrorIfNeeded(context),
          _showSuccessDialog(context),
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

  Widget _showErrorIfNeeded(BuildContext context) {
    return Obx(() {
      return _authViewModel.errorText.value.isNotEmpty
          ? Center(
              child: AlertDialog(
                backgroundColor: Theme.of(context).colorScheme.background,
                title: Text(
                  'Error',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                content: Text(
                  _authViewModel.errorText.value,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      _authViewModel.errorText.value = "";
                      Get.back();
                    },
                    child: Text(
                      "Ok",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  )
                ],
              ),
            )
          : Container();
    });
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 60, left: 26, right: 26),
      child: Column(
        children: [
          _setImage(),
          const SizedBox(height: 40),
          _addTitleDescription(context),
          const SizedBox(height: 45),
          _buildTextFields(context),
          const SizedBox(height: 30),
          _passwordActionButton(context),
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

  Widget _addTitleDescription(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.set_new_password_text,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          AppLocalizations.of(context)!.set_complex_password_description,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              fontWeight: FontWeight.normal,
              fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildTextFields(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: _controller.newPasswordController,
          labelText:
              AppLocalizations.of(context)!.new_password_text_field_label,
          placeholder:
              AppLocalizations.of(context)!.new_password_text_field_placeholder,
          isObscureText: true,
        ),
        const SizedBox(height: 30),
        CustomTextField(
          controller: _controller.confirmPasswordController,
          labelText:
              AppLocalizations.of(context)!.confirm_password_text_field_label,
          placeholder: AppLocalizations.of(context)!
              .confirm_password_text_field_placeholder,
          isObscureText: true,
        ),
      ],
    );
  }

  Widget _passwordActionButton(BuildContext context) {
    return Obx(() {
      return Opacity(
        opacity: (_controller.isValidPassword.value) ? 1.0 : 0.7,
        child: SizedBox(
          width: double.infinity,
          height: 56.0,
          child: ElevatedButton(
            onPressed: (_controller.isValidPassword.value)
                ? () {
                    updatePassword();
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              AppLocalizations.of(context)!.set_new_password_text,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
        ),
      );
    });
  }

  Widget _showSuccessDialog(BuildContext context) {
    return Obx(() {
      if (_authViewModel.resetPasswordSuccess.value) {
        return Center(
          child: AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.background,
            title: Text(
              AppLocalizations.of(context)!.success,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            content: Text(
              AppLocalizations.of(context)!.password_updated_successfully,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  _authViewModel.resetPasswordSuccess.value = false;
                },
                child: Text(
                  "Ok",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          ),
        );
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
