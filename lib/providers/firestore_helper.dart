import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper{
  final db = FirebaseFirestore.instance;

  void printTest(){
    print('provider working');
  }

  Future<dynamic> getUserDataFromDataField(String documentFieldName, String userEmail) async{
    await for (var snapshot in db.collection('users_data').snapshots()) {
      for (var message in snapshot.docs) {
        if(message.data()['user_email'] == userEmail){
          return message.data()[documentFieldName];
        }
      }
    }
  }

  void addDataToFirestore(String collectionName, String documentName, String documentFieldName, dynamic documentData) async{
    await db.collection(collectionName).doc(documentName).set({documentFieldName: documentData}, SetOptions(merge: true));
  }
}