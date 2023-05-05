import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper{

   static Future<dynamic> getUserDataFromDataField(String documentFieldName, String userEmail) async{
     final db = FirebaseFirestore.instance;
     await for (var snapshot in db.collection('users_data').snapshots()) {
       for (var message in snapshot.docs) {
         if(message.data()['user_email'] == userEmail) {
           return message.data()[documentFieldName];
         }
       }
     }
     return null;
  }

   static void addDataToFirestore(String collectionName, String documentName, String documentFieldName, dynamic documentData) async{
     final db = FirebaseFirestore.instance;
    await db.collection(collectionName).doc(documentName).set({documentFieldName: documentData}, SetOptions(merge: true));
  }

  // static Future<Stream> getStreamFromUserData(String userEmail, String documentName) async{
  //   final db = FirebaseFirestore.instance;
  //   print('working');
  //   return db.collection('users_data').doc(userEmail).snapshots();
  // }
}