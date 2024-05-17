import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> fetchAdvertData() async {
  try {
    // Access the Firestore collection
    CollectionReference eventsCollection =
        FirebaseFirestore.instance.collection('events');

    // Retrieve the documents from the collection
    QuerySnapshot querySnapshot = await eventsCollection.get();

    // Iterate through the documents
    querySnapshot.docs.forEach((doc) {
      // Access the fields of each document
      String photo = doc['photo'];
      String description = doc['description'];
      double price = doc['price'];
      String phone = doc['phone'];

      // Do something with the retrieved data
      // For example, print the values
      print('Photo: $photo');
      print('Description: $description');
      print('Price: $price');
      print('Phone: $phone');
    });
  } catch (e) {
    // Handle any errors that occur during the retrieval process
    print('Error retrieving data: $e');
  }
}
