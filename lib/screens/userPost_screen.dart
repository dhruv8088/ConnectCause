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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
class PostListScreen extends StatefulWidget{


  @override
  State<StatefulWidget> createState() => _PostScreenState();
// TODO: implement createState

}

class _PostScreenState extends State<PostListScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<List<DocumentSnapshot>> getDocuments() async {
    QuerySnapshot querySnapshot =
    await firestore.collection('posts').where("user_uid" , isEqualTo: auth.currentUser?.uid).get();
    return querySnapshot.docs;
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
          body: FutureBuilder<List<DocumentSnapshot>>(
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
      print("data : ${data}");
      return ListTile(
      title: Text(data['description']),
      subtitle: Text(data['user_uid']),
      );
      },
      );
      }
      },
          ),
      );
  }
}
