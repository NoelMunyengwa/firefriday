import 'package:firebase_auth/firebase_auth.dart';

class PasswordReset {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print('Password reset email sent to $email');
    } catch (e) {
      print('Failed to send password reset email: $e');
    }
  }
}
