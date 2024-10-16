import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
  AuthViewModel viewModel = AuthViewModel();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email.addListener(updateStates);
    password.addListener(updateStates);
    confirmPassword.addListener(updateStates);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        toolbarHeight: 30,
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 31, right: 31),
            child: Column(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.sign_up_screen_title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: buildTextFields(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                width: double.infinity,
                child: makeSignUpButton(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text:
                          "${AppLocalizations.of(context)!.already_have_an_account} ",
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 14)),
                  TextSpan(
                    text: AppLocalizations.of(context)!.sign_in_button_text,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 11),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print('Login Tapped');
                        Navigator.pop(context);
                      },
                  )
                ])),
              ),
              Container(
                margin: const EdgeInsets.only(top: 60),
                child: ContinueWithView(
                  selectedSocialProviderHandler: (provider) {
                    socialLogin(provider, context);
                  },
                ),
              )
            ]),
          ),
          showLoaderIfNeeded()
        ],
      ),
    );
  }

  Widget buildTextFields() {
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

  Widget makeSignUpButton() {
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
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          child: Text(
            AppLocalizations.of(context)!.signupText,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
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
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
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
    try {
      await viewModel.socialSignin(provider);
      updateLoadingState(false);
      gotoHome(context);
    } catch (err) {
      updateLoadingState(false);
      print('Error = ${err.toString()}');
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
    Get.to(() => HomeScreen());
  }
}
