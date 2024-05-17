import 'package:firefriday/auth/login.dart';
import 'package:firefriday/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:routerino/routerino.dart';
import 'package:firefriday/constants/password_reset.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Forgot Password"),
        // backgroundColor: primaryColor,
      ),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: inputColor,
                  filled: true,
                  prefixIcon: const Icon(Icons.email)),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (emailController.text.contains("@")) {
                  //reset email
                  PasswordReset passwordReset = PasswordReset();
                  try {
                    passwordReset.resetPassword(emailController.text);
                    StylishDialog dialog = StylishDialog(
                      context: context,
                      alertType: StylishDialogType.SUCCESS,
                      title: Text(
                          'Reset link was sent to ${emailController.text}'),
                      dismissOnTouchOutside: false,
                      // confirmButton: const Text('Yes'),
                      cancelButton: InkWell(
                        onTap: () {
                          context.pushRoot(() => const LoginPage());
                        },
                        child: const Text('Close'),
                      ),
                    );
                    dialog.show();

                    // passwordReset.resetPassword(emailController.text);
                    // context.pushRoot(() => const LoginPage());
                  } catch (e) {
                    StylishDialog dialog = StylishDialog(
                      context: context,
                      alertType: StylishDialogType.ERROR,
                      title: Text(
                          'Failed to reset ${emailController.text}\'s password'),
                      dismissOnTouchOutside: false,
                      // confirmButton: const Text('Yes'),
                      cancelButton: InkWell(
                        onTap: () {
                          context.pushRoot(() => const LoginPage());
                        },
                        child: const Text('Close'),
                      ),
                    );
                    dialog.show();
                    print("Error: $e");
                  }
                } else {
                  //return error
                }
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: buttonColor,
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  "Send Reset Email",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
