import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential?> signInAnonymously() async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    return userCredential;
  } catch (e) {
    // Handle any errors that occur during anonymous sign-in
    print('Error signing in anonymously: $e');
    return null;
  }
}

void main() async {
  // Sign in anonymously
  UserCredential? userCredential = await signInAnonymously();

  if (userCredential != null) {
    // Anonymous sign-in successful
    User? user = userCredential.user;
    print('Signed in anonymously with UID: ${user!.uid}');

    // Perform any additional logic here
  } else {
    // Anonymous sign-in failed
    print('Anonymous sign-in failed');
  }
}
