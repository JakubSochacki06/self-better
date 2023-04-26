import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
class StorageHelper{

  static Future<void> uploadFile(String fileName, String userEmail, File file) async{
    final FirebaseStorage storage = FirebaseStorage.instance;
    try{
      await storage.ref('notes/${userEmail}/${fileName}').putFile(file);
    } on FirebaseException catch (e){
      print(e);
    }
  }
}