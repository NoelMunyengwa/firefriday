import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> uploadProfilePicture(String email, String imagePath) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    // Create a reference to the Firebase storage bucket
    Reference storageRef = FirebaseStorage.instance.ref();

    // Generate a unique filename for the profile picture
    String fileName =
        'profile_${email.replaceAll('@', '_').replaceAll('.', '_')}';

    // Upload the image file to Firebase storage
    TaskSnapshot snapshot =
        await storageRef.child(fileName).putFile(File(imagePath));

    // Get the download URL of the uploaded image
    String downloadUrl = await snapshot.ref.getDownloadURL();

    // Update the user's profile picture URL in Firebase Firestore or Realtime Database
    // (Replace this with your own code to update the user's profile picture URL)

    print('Profile picture uploaded successfully');
  } catch (e) {
    print('Error uploading profile picture: $e');
  }
}

//Get profile picture URL
Future<String?> getProfilePicture(String email) async {
  try {
    // Create a reference to the Firebase storage bucket
    Reference storageRef = FirebaseStorage.instance.ref();

    // Generate the filename of the profile picture
    String fileName =
        'profile_${email.replaceAll('@', '_').replaceAll('.', '_')}';

    // Get the download URL of the profile picture
    String downloadUrl = await storageRef.child(fileName).getDownloadURL();

    return downloadUrl;
  } catch (e) {
    print('Error getting profile picture: $e');
    return null;
  }
}

//delete profile picture
Future<void> deleteProfilePicture(String email) async {
  try {
    // Create a reference to the Firebase storage bucket
    Reference storageRef = FirebaseStorage.instance.ref();

    // Generate the filename of the profile picture
    String fileName =
        'profile_${email.replaceAll('@', '_').replaceAll('.', '_')}';

    // Delete the profile picture from Firebase storage
    await storageRef.child(fileName).delete();

    print('Profile picture deleted successfully');
  } catch (e) {
    print('Error deleting profile picture: $e');
  }
}

//Delete account
Future<void> deleteAccount(String email) async {
  try {
    // Delete the user's profile picture
    await deleteProfilePicture(email);

    // Delete the user's account from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.delete();
    }

    print('Account deleted successfully');
  } catch (e) {
    print('Error deleting account: $e');
  }
}
