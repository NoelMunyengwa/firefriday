import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firefriday/auth/forgot_password.dart';
import 'package:firefriday/auth/register.dart';
import 'package:firefriday/business_logic/auth/loginUser.dart';
import 'package:firefriday/business_logic/guests/guests.dart';
import 'package:firefriday/constants/colors.dart';
import 'package:firefriday/constants/message_dialogs.dart';
import 'package:firefriday/dashboard/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:routerino/routerino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  DialogController dialog_controller = DialogController(
    listener: (status) {
      if (status == DialogStatus.Showing) {
        debugPrint("Dialog is showing");
      } else if (status == DialogStatus.Changed) {
        debugPrint("Dialog type changed");
      } else if (status == DialogStatus.Dismissed) {
        debugPrint("Dialog dismissed");
      }
    },
  );

  //delete email in shared prefs
  deleteEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
  }

  @override
  void dispose() {
    dialog_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _header(context),
            _inputField(context),
            _forgotPassword(context),
            // _signup(context),
          ],
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your UZ Portal credentials"),
      ],
    );
  }

  _inputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          decoration: InputDecoration(
              hintText: "Email (john.doe@students.uz.ac.zw)",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: inputColor,
              filled: true,
              prefixIcon: const Icon(Icons.email)),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: inputColor,
            filled: true,
            prefixIcon: const Icon(Icons.lock),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            if (emailController.text.contains("@") &&
                passwordController.text.isNotEmpty) {
              StylishDialog dialog = StylishDialog(
                  context: context,
                  alertType: StylishDialogType.PROGRESS,
                  title: Text('Loading...'),
                  dismissOnTouchOutside: false,
                  controller: dialog_controller);
              StylishDialog error = StylishDialog(
                context: context,
                alertType: StylishDialogType.ERROR,
                title: Text(
                    'Failed to login. Check your credentials or reset password'),
                dismissOnTouchOutside: false,
                confirmButton: InkWell(
                  onTap: () {
                    context.pushRoot(() => const LoginPage());
                  },
                  child: const Text('Close'),
                ),
              );
              dialog.show();
              loginUser(
                email: emailController.text,
                password: passwordController.text,
              ).then((value) => {
                    dialog.dismiss(),
                    if (value!.user!.email!.isNotEmpty)
                      {
                        print("EMAIL: ${value.user!.email.toString()}"),
                        context.pushRoot(() => LandingPage()),
                      }
                    else
                      {error.show()}
                  });

              print('RESPONSE ');

              final FirebaseAuth auth = FirebaseAuth.instance;
              User? user = auth.currentUser;
            } else {
              //return error

              StylishDialog error = StylishDialog(
                context: context,
                alertType: StylishDialogType.ERROR,
                title: Text(
                    'Failed to login. Check your credentials or reset password'),
                dismissOnTouchOutside: false,
                confirmButton: InkWell(
                  onTap: () {
                    context.pushRoot(() => const LoginPage());
                  },
                  child: const Text('Close'),
                ),
              );
              error.show();
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: buttonColor,
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.purple,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: TextButton(
              onPressed: () async {
                //delete email in shared prefs

                StylishDialog dialog = StylishDialog(
                  context: context,
                  alertType: StylishDialogType.WARNING,
                  title: Text(
                      'Logging in as a guest. You can now access limited app features.'),
                  dismissOnTouchOutside: false,
                  confirmButton: InkWell(
                    onTap: () {
                      deleteEmail();
                      StylishDialog loading =
                          loadingBar(context, 'Logging in as guest...');
                      loading.show();
                      signInAnonymously().then((value) => {
                            loading.dismiss(),
                            if (value!.user!.isAnonymous)
                              {
                                print("GUEST: ${value.user!.uid.toString()}"),
                                context.pushRoot(() => LandingPage()),
                              }
                            else
                              {
                                print("GUEST: ${value.user!.uid.toString()}"),
                                context.pushRoot(() => LoginPage()),
                              }
                          });
                    },
                    child: const Text('Continue'),
                  ),
                  cancelButton: InkWell(
                    onTap: () {
                      context.pushRoot(() => const LoginPage());
                    },
                    child: const Text('Cancel'),
                  ),
                );
                dialog.show();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/logo/uzlogo.png'),
                          fit: BoxFit.cover),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 18),
                  const Text(
                    "DISCOVER UZ SERVICES",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _forgotPassword(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.push(() => const ForgotPassword());
      },
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Colors.purple),
      ),
    );
  }

  _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account? "),
        TextButton(
            onPressed: () => context.push(() => const SignupPage()),
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Colors.purple),
            ))
      ],
    );
  }
}
