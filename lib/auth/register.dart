import 'package:firefriday/auth/login.dart';
import 'package:firefriday/business_logic/auth/registerUser.dart';
import 'package:firefriday/constants/colors.dart';
import 'package:firefriday/dashboard/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:routerino/routerino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 60.0),
                    const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create your Varsity Connect account",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    // TextField(
                    //   decoration: InputDecoration(
                    //       hintText: "Username",
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(18),
                    //           borderSide: BorderSide.none),
                    //       fillColor: inputColor,
                    //       filled: true,
                    //       prefixIcon: const Icon(Icons.person)),
                    // ),
                    // const SizedBox(height: 20),
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
                    const SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: inputColor,
                        filled: true,
                        prefixIcon: const Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: passwordConfirmController,
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: inputColor,
                        filled: true,
                        prefixIcon: const Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
                Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),
                    child: ElevatedButton(
                      onPressed: () {
                        StylishDialog dialog = StylishDialog(
                          context: context,
                          alertType: StylishDialogType.PROGRESS,
                          title: Text('Loading...'),
                          dismissOnTouchOutside: false,
                          // controller: dialog_controller
                        );
                        StylishDialog error = StylishDialog(
                          context: context,
                          alertType: StylishDialogType.ERROR,
                          title: Text(
                              'Failed to register. Check your credentials or try again later'),
                          dismissOnTouchOutside: false,
                          confirmButton: InkWell(
                            onTap: () {
                              context.pushRoot(() => const SignupPage());
                            },
                            child: const Text('Close'),
                          ),
                        );
                        StylishDialog successShow = StylishDialog(
                          context: context,
                          alertType: StylishDialogType.SUCCESS,
                          title: Text(
                              'Profile created successfully. Please login to continue'),
                          dismissOnTouchOutside: false,
                          confirmButton: InkWell(
                            onTap: () {
                              context.pushRoot(() => const LoginPage());
                            },
                            child: const Text('Go to login'),
                          ),
                        );
                        if (emailController.text.contains('@') &&
                            passwordController.text.isNotEmpty &&
                            passwordConfirmController.text.isNotEmpty) {
                          dialog.show();
                          registerUser(
                                  emailController.text, passwordController.text)
                              .then((value) => {
                                    dialog.dismiss(),
                                    if (value!.isNotEmpty)
                                      {
                                        successShow.show(),
                                        // context.pushRoot(() => LoginPage()),
                                      }
                                    else
                                      {error.show()}
                                  });

                          final FirebaseAuth auth = FirebaseAuth.instance;
                          User? user = auth.currentUser;

                          // if (user!.email!.isNotEmpty) {
                          //   print("EMAIL: ${user.email.toString()}");
                          //   context.pushRoot(() => LandingPage());
                          // }
                        } else {
                          //show error
                          error.show();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: buttonColor,
                      ),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )),
                const Center(child: Text("Or")),
                // Container(
                //   height: 45,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(25),
                //     border: Border.all(
                //       color: Colors.purple,
                //     ),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.white.withOpacity(0.5),
                //         spreadRadius: 1,
                //         blurRadius: 1,
                //         offset:
                //             const Offset(0, 1), // changes position of shadow
                //       ),
                //     ],
                //   ),
                //   child: TextButton(
                //     onPressed: () {},
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Container(
                //           height: 30.0,
                //           width: 30.0,
                //           decoration: const BoxDecoration(
                //             image: DecorationImage(
                //                 image: AssetImage('assets/logo/firefriday.jpg'),
                //                 fit: BoxFit.cover),
                //             shape: BoxShape.circle,
                //           ),
                //         ),
                //         const SizedBox(width: 18),
                //         const Text(
                //           "Sign In with Google",
                //           style: TextStyle(
                //             fontSize: 16,
                //             color: Colors.purple,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Already have an account?"),
                    TextButton(
                        onPressed: () => context.push(() => const LoginPage()),
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.purple),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
