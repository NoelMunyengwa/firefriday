import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> updateAdvert(String eventId, String photoPath, String description,
    double price, String phone) async {
  // Initialize Firebase
  await Firebase.initializeApp();

  // Upload photo to Firebase Storage
  Reference storageRef =
      FirebaseStorage.instance.ref().child('event_photos').child(eventId);
  await storageRef.putFile(File(photoPath));

  // Get the download URL of the uploaded photo
  String photoUrl = await storageRef.getDownloadURL();

  // Update event data in Firestore
  CollectionReference eventsRef =
      FirebaseFirestore.instance.collection('events');
  await eventsRef.doc(eventId).update({
    'photoUrl': photoUrl,
    'description': description,
    'price': price,
    'phone': phone,
  });

  print('Event updated successfully!');
}
