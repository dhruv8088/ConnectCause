import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class PostManager with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  final CollectionReference<Map<String, dynamic>> _postCollection =
  _firebaseFirestore.collection("posts");
  final CollectionReference<Map<String, dynamic>> _userCollection =
  _firebaseFirestore.collection("users");


  String _message = '';

  String get message => _message; //getter

  setMessage(String message) {
    //setter
    _message = message;
    notifyListeners();
  }

  Future<bool> submitPost({
    String? description,

  }) async {
    bool isSubmitted = false;

    String userUid = _firebaseAuth.currentUser!.uid;
    FieldValue timeStamp = FieldValue.serverTimestamp();


    if (description != null) {
      await _postCollection.doc().set({
        "description": description,
        "createdAt": timeStamp,
        "user_uid": userUid
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
    } else {
      isSubmitted = false;
      setMessage('Image upload failed!');
    }
    return isSubmitted;
  }
}