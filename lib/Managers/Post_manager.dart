//import 'dart:html';

import 'package:ngoapp/screens/signup_screen.dart';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../services/File_upload_service.dart';

class PostManager with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  final CollectionReference<Map<String, dynamic>> _postCollection =
  _firebaseFirestore.collection("posts");
  final CollectionReference<Map<String, dynamic>> _userCollection =
  _firebaseFirestore.collection("users");

  // final FileUploadService _fileUploadService = FileUploadService();



  String _message = '';

  String get message => _message;

  setMessage(String message) {
    //setter
    _message = message;
    notifyListeners();
  }

  Future<bool> submitPost({
    String? description,
    String? profilepic,
    List<String>? tags,
  }) async {
    bool isSubmitted = false;

    String userUid = _firebaseAuth.currentUser!.uid;
    FieldValue timeStamp = FieldValue.serverTimestamp();

    // String? pictureUrl =
    // await _fileUploadService.uploadPostFile(file: postImage);


    if (description != null) {
      await _postCollection.doc('${description}_${_firebaseAuth.currentUser?.email}').set({
        "description": description,
        "createdAt": timeStamp,
        "user_uid": userUid,
        "profile_pic": profilepic,
        "email" : _firebaseAuth.currentUser?.email,
        // "name" : Prop.name,
        "like" : [],
        "completed" : "No",
        "tags":tags,
      }).then((_) {
        isSubmitted = true;
        setMessage('Post submitted successfully!');
      }).catchError((onError) {
        isSubmitted = false;
        setMessage('$onError');
      }).timeout(const Duration(seconds: 60), onTimeout: () {
        isSubmitted = false;
        setMessage('Please check your internet connection.');
      });
    }
    else {
      isSubmitted = false;
      setMessage('Image upload failed!');
    }
    return isSubmitted;
  }
}