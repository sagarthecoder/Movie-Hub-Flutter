import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Service/AuthService/AuthService.dart';
import '../../../CustomViews/Field/CustomTextField.dart';
import '../../../Home/Views/HomeScreen.dart';
import '../../CommonViews/ContinueWithView.dart';
import '../../Login/Model/OauthEnums.dart';
import '../../Login/ViewModel/AuthViewModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final viewModel = Get.put(AuthViewModel());
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    viewModel.isLoading.value = false;
    viewModel.errorText.value = "";
    viewModel.loginSuccess.value = false;
    email.addListener(updateStates);
    password.addListener(updateStates);
    confirmPassword.addListener(updateStates);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void updateStates() {
    setState(() {});
  }

  void updateLoadingState(bool isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primaryContainer,
        toolbarHeight: 30,
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 31, right: 31),
            child: Column(children: [
              _buildTitle(context),
              const SizedBox(
                height: 40,
              ),
              buildTextFields(context),
              const SizedBox(
                height: 50,
              ),
              makeSignUpButton(context),
              _buildRichText(context),
              const SizedBox(
                height: 60,
              ),
              ContinueWithView(
                selectedSocialProviderHandler: (provider) {
                  socialLogin(provider, context);
                },
              ),
            ]),
          ),
          showLoaderIfNeeded()
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        AppLocalizations.of(context)!.sign_up_screen_title,
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onBackground,
        ),
      ),
    );
  }

  Widget buildTextFields(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
            placeholder:
                AppLocalizations.of(context)!.email_text_field_placeholder,
            labelText: AppLocalizations.of(context)!.email_text_field_label,
            controller: email),
        const SizedBox(
          height: 26,
        ),
        CustomTextField(
            placeholder:
                AppLocalizations.of(context)!.password_text_field_placeholder,
            labelText: AppLocalizations.of(context)!.password_text_field_label,
            controller: password),
        const SizedBox(
          height: 26,
        ),
        CustomTextField(
            placeholder: AppLocalizations.of(context)!
                .confirm_password_text_field_placeholder,
            labelText:
                AppLocalizations.of(context)!.confirm_password_text_field_label,
            controller: confirmPassword),
      ],
    );
  }

  Widget makeSignUpButton(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Opacity(
        opacity: isEnabledSignUpButton() ? 1.0 : 0.4,
        child: ElevatedButton(
          onPressed: isEnabledSignUpButton()
              ? () {
                  print("Sign up button pressed");
                  signup(context);
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.secondary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(
            AppLocalizations.of(context)!.signupText,
            style: theme.textTheme.labelLarge
                ?.copyWith(color: theme.colorScheme.onPrimary, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildRichText(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: "${AppLocalizations.of(context)!.already_have_an_account} ",
            style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onBackground, fontSize: 14)),
        TextSpan(
          text: AppLocalizations.of(context)!.sign_in_button_text,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              print('Login Tapped');
              Navigator.pop(context);
            },
        )
      ])),
    );
  }

  bool isEnabledSignUpButton() {
    return (email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        confirmPassword.text.isNotEmpty &&
        password.text == confirmPassword.text);
  }

  Widget showLoaderIfNeeded() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Container();
    }
  }

  showAlertDialog(BuildContext context, String message,
      [String title = 'Alert!']) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(title, style: Theme.of(context).textTheme.titleLarge),
      content: Text(message, style: Theme.of(context).textTheme.bodyLarge),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> socialLogin(
      SocialSignInProvider provider, BuildContext context) async {
    updateLoadingState(true);
    viewModel.loginSuccess.value = false;
    try {
      await viewModel.socialSignin(provider);
      updateLoadingState(false);
      if (context.mounted && viewModel.loginSuccess.value) {
        gotoHome(context);
      }
    } catch (err) {
      updateLoadingState(false);
      print('Error = ${err.toString()}');
      if (!context.mounted) return;
      showAlertDialog(context, err.toString());
    }
  }

  Future<void> signup(BuildContext context) async {
    updateLoadingState(true);
    try {
      await AuthService.shared.signupWithEmail(email.text, password.text);
      updateLoadingState(false);
      gotoHome(context);
    } catch (err) {
      print("Error = ${err.toString()}");
      updateLoadingState(false);
      showAlertDialog(context, err.toString());
    }
  }

  void gotoHome(BuildContext context) {
    Future.microtask(() => Get.to(() => HomeScreen()));
  }
}
