import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> deleteAdvertData(String documentId) async {
  try {
    await FirebaseFirestore.instance
        .collection('events')
        .doc(documentId)
        .delete();
    print('Event data deleted successfully!');
  } catch (e) {
    print('Error deleting event data: $e');
  }
}
