import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<UserCredential?> loginUser({
  required String email,
  required String password,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  try {
    final userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    prefs.setString('email', email);
    print(" DONE LOGIN");
    return userCredential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return null;
    } else if (e.code == 'wrong-password') {
      return null;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
