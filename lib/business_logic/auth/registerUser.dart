import 'package:firebase_auth/firebase_auth.dart';

Future<String?> registerUser(String email, String password) async {
  try {
    final userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential != null) {
      // Return user access token
      String? accessToken = await userCredential.user?.getIdToken();
      print('User registered successfully: ${userCredential.user}');
      return accessToken;
    }
    return null;
  } catch (e) {
    // Registration failed, handle the error
    print('Registration failed: $e');
    return null;
  }
}
