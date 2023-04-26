import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper{

   static Future<dynamic> getUserDataFromDataField(String documentFieldName, String userEmail) async{
     final db = FirebaseFirestore.instance;
    final docRef = db.collection("users_data").doc(userEmail);
    docRef.get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        return data[documentFieldName];
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

   static void addDataToFirestore(String collectionName, String documentName, String documentFieldName, dynamic documentData) async{
     final db = FirebaseFirestore.instance;
    await db.collection(collectionName).doc(documentName).set({documentFieldName: documentData}, SetOptions(merge: true));
  }
}