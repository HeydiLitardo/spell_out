import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDocument(String collection, Map<String, dynamic> data) {
    return _firestore.collection(collection).add(data);
  }

  Future<void> updateDocument(
      String collection, String documentId, Map<String, dynamic> data) {
    return _firestore.collection(collection).doc(documentId).update(data);
  }

  Future<void> deleteDocument(String collection, String documentId) {
    return _firestore.collection(collection).doc(documentId).delete();
  }

  Future<List<Map<String, dynamic>>> getDocuments(String collection) async {
    QuerySnapshot snapshot = await _firestore.collection(collection).get();
    List<Map<String, dynamic>> documents = [];
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      var data = doc.data();
      if (data is Map<dynamic, dynamic>) {
        documents.add(Map<String, dynamic>.from(data));
      }
    }
    return documents;
  }

  // get document by id query snapshot
  Future<Map<String, dynamic>> getDocumentById(
      String collection, String id) async {
    QuerySnapshot snapshot = await _firestore
        .collection(collection)
        .where('id', isEqualTo: id)
        .get();
    Map<String, dynamic> document = {};
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      var data = doc.data();
      if (data is Map<dynamic, dynamic>) {
        document = Map<String, dynamic>.from(data);
      }
    }
    return document;
  }

  // get document id by id query snapshot
  Future<String> getDocumentIdById(String collection, String id) async {
    QuerySnapshot snapshot = await _firestore
        .collection(collection)
        .where('id', isEqualTo: id)
        .get();
    String documentId = '';
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      documentId = doc.id;
    }
    return documentId;
  }

  // get document by query snapshot
  Future<Map<String, dynamic>> getDocumentByQuery(
      String collection, String field, dynamic value) async {
    QuerySnapshot snapshot = await _firestore
        .collection(collection)
        .where(field, isEqualTo: value)
        .get();
    Map<String, dynamic> document = {};
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      var data = doc.data();
      if (data is Map<dynamic, dynamic>) {
        document = Map<String, dynamic>.from(data);
      }
    }
    return document;
  }
}
