// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'package:flutter/cupertino.dart';
//
// class UserPostScreen extends StatefulWidget{
//   UserPostScreen({required this.email});
//   final String email;
//
//   @override
//   State<StatefulWidget> createState() => _UserPostScreenState()  ;
// // TODO: implement createState
//
// }
//
// class _UserPostScreenState extends State<UserPostScreen> {
//   @override
//   Widget build(BuildContext context) {
//
//
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }

// class _UserPostScreenState extends State<UserPostScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final formKey = GlobalKey<FormState>();
//     String postContent = '';
//
//     void _submitForm() async {
//       if (formKey.currentState!.validate()) {
//         formKey.currentState!.save();
//         final user = FirebaseAuth.instance.currentUser!;
//         final post = Post(
//           content: postContent,
//           authorId: user.uid,
//           createdAt: DateTime.now(),
//         );
//         await FirebaseFirestore.instance
//             .collection('users').doc(widget.email)
//             .update({'posts' : FieldValue.arrayUnion(post.toJson() as List)});
//         Navigator.pop(context);
//       }
//     }
//     StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('users').doc(widget.email).snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const CircularProgressIndicator();
//         }
//         final posts = snapshot.data!.docs
//             .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>?))
//             .toList();
//         return ListView.builder(
//           itemCount: posts.length,
//           itemBuilder: (context, index) {
//             final post = posts[index];
//             return ListTile(
//               title: Text(post.content),
//               subtitle: Text(post.authorId),
//             );
//           },
//         );
//       },
//     );
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
//
// class Post {
//   final String content;
//   final String authorId;
//   final DateTime createdAt;
//
//
//   Post({
//     required this.content,
//     required this.authorId,
//     required this.createdAt,
//
//   });
//
//   Map<String, dynamic> toJson() {
//     return {
//       'content': content,
//       'authorId': authorId,
//       'createdAt': createdAt,
//
//     };
//   }
//
//   factory Post.fromJson(Map<String, dynamic>? json) {
//     return Post(
//       content: json!['content'],
//       authorId: json['authorId'],
//       createdAt: (json['createdAt'] as Timestamp).toDate(),
//
//     );
//
//   }
// }
//
//
//
import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ngoapp/screens/Validation_form.dart';


class MyApppost extends StatefulWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Posts')),
        body: PostListScreen(),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class Completed extends ChangeNotifier{
  Completed({required this.isCompleted});
  bool isCompleted = false;

  void changeIsCompleted() {
    this.isCompleted = !isCompleted;
    notifyListeners();
  }
}





class PostListScreen extends StatefulWidget{


  @override
  State<StatefulWidget> createState() => _PostScreenState();
// TODO: implement createState

}

class _PostScreenState extends State<PostListScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  // bool c = false;
  TextEditingController _promptController = TextEditingController();
  TextEditingController _promptController2 = TextEditingController();
  TextEditingController _promptController3 = TextEditingController();




  bool ActivityCompleted(postID){
    bool c = false;
    FirebaseFirestore firestorm = FirebaseFirestore.instance;
    final postRef = firestorm.collection("posts").doc(postID);
    postRef.update({'completed':'Yes'});
    c = true;
    return true;
    
  }
  bool validation(postID){
    bool c = true;
    firestore.collection("posts").doc(postID).get().then(
        (DocumentSnapshot doc){
          final data = doc.data() as Map<String , dynamic>;
          if(data['completed']=='Yes'){
            c = true;
          }

          
        }
    );
    return c;
  }
   
  Future<List<DocumentSnapshot>> getDocuments() async {
    QuerySnapshot querySnapshot =
    await firestore.collection('posts').where("user_uid" , isEqualTo: auth.currentUser?.uid).get();
    return querySnapshot.docs;
  }
  var counter = 0;
  void _refreshScreen() {
    setState(() {
      counter++;
    });
  }

  List<String> _list = List.generate(10, (index) => 'Item ${index + 1}');
  Future<void> _refreshList() async {
    // simulate a data fetch operation
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _list = List.generate(10, (index) => 'Item ${index + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder<QuerySnapshot>(
    //   stream: query.snapshots(), // pehle query likhi aur query.snapshots() ko stream bna diya ..jiss se filtered data aa rha
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     if (!snapshot.hasData) {
    //       return CircularProgressIndicator();
    //     }
    //     final posts = snapshot.data!.docs;
    //
    //     return ListView.builder(
    //         itemCount: posts?.length,
    //         itemBuilder: (context, index) {
    //           var  post = posts[index]?.data() as Map<String, dynamic>;
    //           var title;
    //           var body;
    //
    //
    //           // final userPosts =
    //           // _firestore.collection("posts").where("user_uid" , isEqualTo: auth.currentUser?.uid).get().then(
    //           //       (querySnapshot) {
    //           //     print("Successfully completed");
    //           //     for (var docSnapshot in querySnapshot.docs) {
    //           //       print(docSnapshot.data()['description']);
    //           //       print(docSnapshot);
    //           //       title = docSnapshot.data()['description'];
    //           //       body = docSnapshot.data()['user_uid'];
    //           //
    //           //         ListTile(
    //           //           title : Text("${title}"),
    //           //           subtitle: Text("${body}"),
    //           //
    //           //         );
    //           //
    //           //     }
    //           //   },
    //           //   onError: (e){ print("Error completing: $e");
    //           //
    //           //       }
    //           // );
    //           final currentUser = FirebaseAuth.instance.currentUser!;
    //           final query = FirebaseFirestore.instance
    //               .collection('posts')
    //               .where('authorId', isEqualTo: currentUser.uid)
    //               .orderBy('createdAt', descending: true);
    //
    //           return Material(
    //             child: ListTile(
    //
    //             ),
    //           );
    //
    //
    //         }
    //
    //     );
    //   },
    // );


    print("get Docsss : ${getDocuments()}");
      return Scaffold(
          appBar: AppBar(
            title: Text("My Posts"),
          ),

          body: RefreshIndicator(
            onRefresh: _refreshList,
            child: FutureBuilder<List<DocumentSnapshot>>(
            future: getDocuments(),
      builder: (BuildContext context,
      AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
              print("Snapshotsssss : ${snapshot}");
      if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(
      child: CircularProgressIndicator(),
      );
      } else if (snapshot.hasError) {
      return Center(
      child: Text('Error: ${snapshot.error}'),
      );
      } else {
      List<DocumentSnapshot> documents = snapshot.data!;
      print("Snapshotsssss dataaaaa ${snapshot.data!}");
      return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (BuildContext context, int index) {
      final data = documents[index];
      var postID = '${data['description']}_${data['email']}';

      print("data : ${data}");
      print("length : ${documents.length + 1}");
      return
        Material(
          elevation: 35,
          borderRadius: BorderRadius.circular(30),
        child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Container(

          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
            ),
                borderRadius: BorderRadius.circular(20)
          ),
          child: Container(
            margin: const EdgeInsets.fromLTRB( 0, 10, 0, 0),
            width: MediaQuery.of(context).size.width / 1.25,
            child: Column(
              mainAxisAlignment : MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Row(
                  children: [
                    Icon(Icons.account_circle_rounded , size: 30,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.35,
                    ),
                    // Text(
                    //   // data['name']
                    // ),
            InkWell(

                onTap : (){

                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     // return AlertDialog(
                  //     //   title: Row(
                  //     //     children: [
                  //     //       Text('From'),
                  //     //       SizedBox(
                  //     //         width: MediaQuery.of(context).size.width / 22
                  //     //       ),
                  //     //       Text('Type'),
                  //     //       SizedBox(
                  //     //           width: MediaQuery.of(context).size.width / 22
                  //     //       ),
                  //     //       Text('To'),
                  //     //
                  //     //     ],
                  //     //   ),
                  //     //   content: Row(
                  //     //     children: [
                  //     //       TextField(
                  //     //         onChanged: (value){
                  //     //
                  //     //         },
                  //     //         controller: _promptController,
                  //     //         // decoration: InputDecoration(
                  //     //         //   hintText: "Url of your Excel Sheet here",
                  //     //         // ),
                  //     //       ),
                  //     //       TextField(
                  //     //         onChanged: (value){
                  //     //
                  //     //         },
                  //     //         controller: _promptController2,
                  //     //         // decoration: InputDecoration(
                  //     //         //   hintText: "Url of your Excel Sheet here",
                  //     //         // ),
                  //     //       ),
                  //     //       TextField(
                  //     //         onChanged: (value){
                  //     //
                  //     //         },
                  //     //         controller: _promptController3,
                  //     //         // decoration: InputDecoration(
                  //     //         //   hintText: "Url of your Excel Sheet here",
                  //     //         // ),
                  //     //       ),
                  //     //     ],
                  //     //   ),
                  //     // );
                  //   },
                  // );
                  ActivityCompleted(postID);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MyAlertDialog()));
                },
                child: (validation(postID))? Icon(
                  Icons.verified, color: Colors.green,
                ): Icon(
                  Icons.radio_button_off_rounded , color: Colors.grey,
                )
              )
                  ],
                ),

            Image.network(
                  data['profile_pic'],
                  height : 200,
                  width : MediaQuery.of(context).size.width/1.12,
                  fit: BoxFit.cover,

              ),
                SizedBox(
                  height: 10
                ),
                Row(

                  children: [

                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                      width: MediaQuery.of(context).size.width / 1.25,
                     
                      child: Text(
                          data['description']
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                )


              ],
            ),
          ),

      ),
        )
        );
      //   ListTile(
      // leading: Icon(
      //   Icons.account_box,
      //
      //   size: 35,
      // ),
      // subtitle: Text(data['description']
      // ),
      //   title: Image.network(
      //       data['profile_pic'],
      //       height : 160,
      //       width : 30,
      //       fit: BoxFit.cover,
      //
      //   ),
      // );
      },
      );
      }
      },
            ),
          ),
      );
  }

}

