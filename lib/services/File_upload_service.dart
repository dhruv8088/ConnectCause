// import 'dart:io';
//
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
//
//
//
//   Future<String?> uploadPostFile({required File file}) async {
//     try {
// import 'package:path/path.dart';
//
// class FileUploadService {
//   final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
//       String fileName = basename(file.path);
//
//       Reference storageRef =
//       _firebaseStorage.ref().child('post_images').child(fileName);
//
//       UploadTask storageUploadTask = storageRef.putFile(file);
//
//       TaskSnapshot snapshot = await storageUploadTask
//           .whenComplete(() => storageRef.getDownloadURL());
//
//       return await snapshot.ref.getDownloadURL();
//     } catch (e) {
//       debugPrint('############ $e');
//       return null;
//     }
//   }
// }