import 'package:ngoapp/screens/signup_screen.dart';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../services/File_upload_service.dart';

class UserProfileManager with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  final CollectionReference<Map<String, dynamic>> _UserProfileCollection =
  _firebaseFirestore.collection("userProfile");
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
    String? bio,
    String? qrpic,
  }) async {
    bool isSubmitted = false;

    String userUid = _firebaseAuth.currentUser!.uid;


    // String? pictureUrl =
    // await _fileUploadService.uploadPostFile(file: postImage);


    if (bio != null) {
      await _UserProfileCollection.doc(
          '${bio}_${_firebaseAuth.currentUser?.email}').set({
        "bio": bio,
        "user_uid": userUid,
        "qr_pic": qrpic,
        "email": _firebaseAuth.currentUser?.email,
        // "name" : Prop.name,

      }).then((_) {
        isSubmitted = true;
        setMessage('QR submitted successfully!');
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