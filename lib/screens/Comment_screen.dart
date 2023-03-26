// import 'dart:html';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
//
// class Comment {
//   final String ownerName;
//   final String comment;
//
//   Comment({required this.ownerName, required this.comment});
//
//   factory Comment.fromMap(Map<String, dynamic> map) {
//     return Comment(
//       ownerName: map['ownerName'],
//       comment: map['comment'],
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'ownerName': ownerName,
//       'comment': comment,
//     };
//   }
// }

import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';

var userEmail="";
var postId="";

class CommentScreen extends StatefulWidget {
  // var userEmail;
  // var postId;
  CommentScreen(_userEmail, _postId) {
    print(_postId);
    userEmail = _userEmail;
    postId = _postId;
  }



  @override
  _CommentScreenState createState() => _CommentScreenState();
}



class _CommentScreenState extends State<CommentScreen> {
  final formKey = GlobalKey<FormState>();

  List<String> _list = List.generate(100, (index) => 'Item ${index + 1}');
  Future<void> _refreshList() async {

      await getComments();
    // simulate a data fetch operation
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _list = List.generate(10, (index) => 'Item ${index + 1}');
    });
  }
  final TextEditingController commentController = TextEditingController();

  List <Map<String, dynamic>> commentData = [];

  int _count =0;

  // Future<void> _refreshScreen()async {
  //   setState(() {
  //     _count++;
  //   });
  // }

  Future<void> getComments() async {
    print("post id inside get commnets ${postId}");
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection('comments').where('post_id', isEqualTo: postId).get();
    commentData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print("comment list initial: ${commentData}");



  }

  @override
  void initState(){

    print('init state');
    _refreshList();
    // TODO: implement initState
    super.initState();
  }


  List filedata = [
    {
      'name': 'Chuks Okwuenu',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to code',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://www.adeleyeayodeji.com/img/IMG_20200522_121756_834_2.jpg',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Tunde Martins',
      'pic': 'assets/img/userpic.jpg',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
  ];

  // String _message = '';
  //
  // String get message => _message;
  //
  // setMessage(String message) {
  //   //setter
  //   _message = message;
  //   // notifyListeners();
  // }
  Future<bool> addComment(String commentText) async {
    // Get a reference to the comments collection
    CollectionReference commentsRef = FirebaseFirestore.instance.collection('comments');
    bool isSubmitted = false;
    // Add a new comment document to the comments collection
    if(commentText != "") {
      await commentsRef.doc().set({
        'post_id': postId,
        'comment_text': commentText,
        'user_email' : userEmail,
        'timestamp': FieldValue.serverTimestamp(),
      }).then((_) {
        isSubmitted = true;
        // setMessage('Comment submitted successfully!');
      }).catchError((onError) {
        isSubmitted = false;
        // setMessage('$onError');
      }).timeout(const Duration(seconds: 60), onTimeout: () {
        isSubmitted = false;
        // setMessage('Please check your internet connection.');
      });
    } else {
      isSubmitted = false;
      // setMessage('Comment upload failed!');
    }
    return isSubmitted;


  }


  Widget commentChild(data) {

    return
    ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");

                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        "assets/Images/profile.jpg",
                          )
                      )
                ),
              ),
              title: Text(
                data[i]['user_email'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['comment_text']),
              // trailing: Text(data[i]['timestamp'], style: TextStyle(fontSize: 10)),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Comment Page"),
        backgroundColor: Colors.blueGrey,
         // leading:  ElevatedButton(
         //    child:Text("Refresh for comments"),
         //    onPressed: () async {
         //      await getComments();
         //      print("commentdataonrefresh ${commentData}");
         //      await _refreshScreen();
         //    }
         //  )


      ),

      body: RefreshIndicator(
        onRefresh: _refreshList,
        child: Container(

            child: CommentBox(
              userImage: CommentBox.commentImageParser(
                  imageURLorPath: "assets/Images/profile.jpg"),

              child: commentChild(commentData),
              labelText: 'Write a comment...',
              errorText: 'Comment cannot be blank',
              withBorder: false,
              sendButtonMethod:() async {
                bool success = false;
                if (formKey.currentState!.validate()) {
                  print(commentController.text);
                  setState(() {
                    var value = {
                      'name': 'New User',
                      'pic':
                      'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                      'message': commentController.text,
                      'date': '2021-01-01 12:00:00'
                    };
                    filedata.insert(0, value);


                  });
                  // success = await addComment(commentController.text);
                  // print(success);
                  // print(success);
                  // if(success == true) {
                  //   print('inside if');
                  //   commentController.clear();
                  //   FocusScope.of(context).unfocus();
                  // }
                  // await getComments();
                  addComment(commentController.text).then((success) {
                  print(success);
                  if (success) {
                  print('inside if');
                  commentController.clear();
                  FocusScope.of(context).unfocus();
                  }
                  });
                  // commentController.clear();
                  // FocusScope.of(context).unfocus();
                } else {
                  print("Not validated");
                }
              },
              formKey: formKey,
              commentController: commentController,
              backgroundColor: Colors.blueGrey,
              textColor: Colors.white,
              sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
            ),
          ),
      ),
    );
  }
}