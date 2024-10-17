import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_hub/Modules/UISections/Home/Views/HomeScreen.dart';
import 'package:movie_hub/Modules/UISections/Oauth/ForgetPassword/Views/ForgetPasswordView.dart';

import '../../../../Service/AuthService/AuthService.dart';
import '../../../CustomViews/Field/CustomTextField.dart';
import '../../CommonViews/ContinueWithView.dart';
import '../../Signup/Views/SignupScreen.dart';
import '../Model/OauthEnums.dart';
import '../ViewModel/AuthViewModel.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthViewModel viewModel = AuthViewModel();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    email.addListener(updateStates);
    password.addListener(updateStates);
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
          toolbarHeight: 30,
        ),
        body: Stack(children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 31, right: 31),
            child: Column(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.sign_in_button_text,
                  style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onBackground,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: buildTextFields(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Get.to(() => ForgetPasswordView());
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          AppLocalizations.of(context)!.forgot_password_text,
                          style: TextStyle(color: theme.colorScheme.primary),
                        ),
                      )),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 26),
                width: double.infinity,
                child: makeSignInButton(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text:
                          "${AppLocalizations.of(context)!.dont_have_account_text} ",
                      style: TextStyle(
                          color:
                              theme.colorScheme.onBackground.withOpacity(0.7),
                          fontSize: 14)),
                  TextSpan(
                    text: AppLocalizations.of(context)!.signupText,
                    style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 11),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return const SignupScreen();
                        }));
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
          showLoaderIfNeeded(),
        ]));
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
      child: Text("OK",
          style: TextStyle(color: Theme.of(context).colorScheme.primary)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(title,
          style: TextStyle(color: Theme.of(context).colorScheme.primary)),
      content: Text(message),
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

  Widget buildTextFields() {
    return Column(
      children: [
        CustomTextField(
          placeholder:
              AppLocalizations.of(context)!.email_text_field_placeholder,
          labelText: AppLocalizations.of(context)!.email_text_field_label,
          controller: email,
        ),
        const SizedBox(
          height: 26,
        ),
        CustomTextField(
          placeholder:
              AppLocalizations.of(context)!.password_text_field_placeholder,
          labelText: AppLocalizations.of(context)!.password_text_field_label,
          controller: password,
        ),
      ],
    );
  }

  Widget makeSignInButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: Opacity(
        opacity: isEnabledLoginButton() ? 1.0 : 0.4,
        child: ElevatedButton(
          onPressed: isEnabledLoginButton()
              ? () {
                  print("Sign in button pressed");
                  signIn(context);
                }
              : null,
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          child: Text(
            AppLocalizations.of(context)!.sign_in_button_text,
            style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          ),
        ),
      ),
    );
  }

  bool isEnabledLoginButton() {
    return (email.text.isNotEmpty && password.text.isNotEmpty);
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

  Future<void> signIn(BuildContext context) async {
    updateLoadingState(true);
    try {
      await AuthService.shared.signInWithEmail(email.text, password.text);
      updateLoadingState(false);
      gotoHome(context);
    } catch (err) {
      updateLoadingState(false);
      print('Error = ${err.toString()}');
      showAlertDialog(context, err.toString());
    }
  }

  void gotoHome(BuildContext context) {
    Get.to(() => HomeScreen());
  }
}
