import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> createAdvert(
    String photo, String description, double price, String phone) async {
  // Initialize Firebase
  await Firebase.initializeApp();

  // Get a reference to the Firestore collection
  CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection('events');

  // Create a new document with auto-generated ID
  DocumentReference newEventRef = eventsCollection.doc();

  // Set the data for the new event
  await newEventRef.set({
    'photo': photo,
    'description': description,
    'price': price,
    'phone': phone,
  });

  print('Event created successfully!');
}
