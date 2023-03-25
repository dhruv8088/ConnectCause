

import 'dart:core';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ngoapp/screens/Chat_screen.dart';
import 'package:ngoapp/screens/Comment_screen.dart';
import 'package:ngoapp/screens/Postform_screen.dart';
import 'package:ngoapp/screens/UserProfile_Screen.dart';
import 'package:ngoapp/screens/singin_screen.dart';
import 'package:ngoapp/screens/signup_screen.dart';
import 'package:ngoapp/screens/userPost_screen.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class HomeScreen extends StatefulWidget{
  HomeScreen({required this.email });
  final String email ;

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
// TODO: implement createState

}

class _HomeScreenState extends State<HomeScreen>{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  int _count =0;


  void _refreshScreen(){
    setState(() {
      _count++;
    });
  }
  Map<String , dynamic>? PostuserMap;
  bool isLoading = false;
  late var post_email ;
  String username = "";
  String usernumber = "";
  // late num usernumber;
  List<String> post_mail= [];
  List<Map<String , dynamic >> user_mail = [];
  // Future<void> CollectUsers() async{
  //   print('hello from collect usrd');
  //   QuerySnapshot querySnapshot = (await firestore.collection('users').get());
  //   print('Query Snapshot of collect users: ${querySnapshot}');
  //   List<AsyncSnapshot<DocumentSnapshot>> snapshot = querySnapshot.docs as List<AsyncSnapshot<DocumentSnapshot<Object?>>>;
  //   for(int i=0;i<snapshot.length;i++) {
  //     DocumentSnapshot documents1 = snapshot[i].data! as DocumentSnapshot<Object?>;
  //     print('document1 : ${documents1}');
  //     user_mail.add(documents1 as Map<String, String>);
  //   }
  //
  //
  // }

  Future<void> CollectUsers() async {
    print('Hello from collectUsers!');
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection('users').get();
    print('Query Snapshot of collectUsers: ${querySnapshot}');
    user_mail =
    querySnapshot.docs.map((doc) => doc.data()).toList();
    print('Users List: ${user_mail}');
    // for (var user in users) {
    //   user_mail.add(user as Map<String, String>);
    // }
    // print('User Emails List: ${user_mail}');
  }

  String? Compare(postEmail) {
  // for(int i = 0; i < post_mail.length ; i++){
  //   await CollectUsers();
    print('hello from Compare');
    print(user_mail);
    print(postEmail);
    // print('user email : ${user_mail[0]['email']}');
    for(int j = 0; j< user_mail.length ; j++) {
      if(postEmail == user_mail[j]['email']) {
        print('my name : ${user_mail[j]['name']}');
        return (user_mail[j]['name']);

      }
    }
  // }
  }

  String? getUserNumber(postEmail) {

    for(int j = 0; j< user_mail.length ; j++) {
      if(postEmail == user_mail[j]['email']) {
        print('my name : ${user_mail[j]['name']}');
        return (user_mail[j]['number']);

      }
    }

  }

  Map<String, dynamic>? getCurrentUser(currentUserEmail) {
    for(int j = 0; j< user_mail.length ; j++) {
      if(currentUserEmail == user_mail[j]['email']) {
        print('my name : ${user_mail[j]['name']}');
        return (user_mail[j]);

      }
    }
  }

  List<Map<String, dynamic>> getLocationNGO(userLocation) {
    List<Map<String, dynamic>> NgoList = [];
    print("user location : ${userLocation}");
    for (int j = 0; j<user_mail.length; j++) {
      print("heloo from ngo ${user_mail.length}");
      if(user_mail[j]['selected_field'] == "NGO" && user_mail[j]['location'] == userLocation) {
        print("one Ngo : ${user_mail[j]}");
        NgoList.add((user_mail[j]));
      }
    }
    return NgoList;
  }


  void onPost() async {

    FirebaseFirestore firestorm = FirebaseFirestore.instance;
    await firestorm.collection('users').
    where("email", isEqualTo: post_email).
    get().then((value) {
      setState(() {
        PostuserMap = value.docs[0].data();
        isLoading = true;
      });
      if(isLoading){
        return;
      }

    });

  }

  List<String> _list = List.generate(100, (index) => 'Item ${index + 1}');
  Future<void> _refreshList() async {


    // simulate a data fetch operation

    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _list = List.generate(10, (index) => 'Item ${index + 1}');
    });
  }

  void onLike(postID) {
    FirebaseFirestore firestorm = FirebaseFirestore.instance;
    final postRef = firestorm.collection("posts").doc(postID);
    postRef.update({"like" : FieldValue.arrayUnion([auth.currentUser?.email])});
  }

  List<String> postLikedStatus = [];
  Future<void> likedStatus(postID) async {
    FirebaseFirestore firestorm = FirebaseFirestore.instance;
    final postRef = firestorm.collection("posts").doc(postID);

    postRef.get().then(
            (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          if(data['like'].contains(auth.currentUser?.email)) {
            postLikedStatus.add(postID);
          }

        },
        onError: (e) => print("Error getting document: $e"),


    );

  }

  int liked = 0;

  Future<List<QueryDocumentSnapshot<Object?>>> getDocuments() async {
    await CollectUsers();

    Map<String, dynamic>? currentUser  = getCurrentUser(auth.currentUser?.email);
    List<dynamic> currentUserFollowing = currentUser!['following'];
    print(currentUserFollowing);
    List<QuerySnapshot> listQuerySnapShots = [];

    QuerySnapshot querySnapshot =
    await firestore.collection('posts').where("user_uid" , isEqualTo: auth.currentUser?.uid).get();

    for(int i=0; i< currentUserFollowing.length; i++) {
      QuerySnapshot querySnapshot1 =
      await firestore.collection('posts').where("email" , isEqualTo: currentUserFollowing[i]).get();
      listQuerySnapShots.add(querySnapshot1);
    }

    if (currentUser['selected_field'] == 'Individual') {
      String userLocation = currentUser['location'];
      List<Map<String, dynamic>> listNgo = getLocationNGO(userLocation);
      print('listNgo : ${listNgo}');

      for(int i = 0; i<listNgo.length;i++) {
        QuerySnapshot querySnapshot2 =
        await firestore.collection('posts').where("email" , isEqualTo: listNgo[i]['email']).get();
        listQuerySnapShots.add(querySnapshot2);
      }
    }



    List<QueryDocumentSnapshot<Object?>> queryDocs = [];
    for (int i = 0; i < listQuerySnapShots.length; i++) {
      queryDocs.addAll(listQuerySnapShots[i].docs);
    }

    List<Map<String, dynamic>> documents = [];
    for(int i=0;i<queryDocs.length;i++) {
       documents.add(queryDocs[i].data() as Map<String, dynamic>);
       for(int j = 0; j<documents.length;j++) {
         await likedStatus('${documents[j]['description']}_${documents[j]['email']}');
       }
      
    }
    return queryDocs;
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect Cause'),
        backgroundColor: Colors.blueGrey,
        actions: <Widget> [
          IconButton(

            alignment: Alignment.center,
            icon: Icon(Icons.chat_bubble_rounded , color: Colors.white),
            onPressed: (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));

            },
            iconSize: 35,


          ),
          SizedBox(
            width: 30,
          ),
          IconButton(
            alignment: Alignment.topLeft,
            icon: Icon(Icons.person_2_outlined),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileScreen(email : widget.email)));
            },
            iconSize: 32,
            color: Colors.white,

          ),

        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshList,
        child: Container(
          child: FutureBuilder<List<DocumentSnapshot>>(
            future: getDocuments(),
            builder: (BuildContext context,
                AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
              print("Snapshotsssss : ${snapshot}");
              // CollectUsers();
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
                    print("length : ${documents.length + 1}");
                    post_email = data['email'];


                    print(post_email);
                    // post_mail.add(post_email);
                    username = Compare(post_email) as String ;
                    usernumber = getUserNumber(post_email)!;
                    print(username);
                    print(usernumber);

                    // QuerySnapshot<dynamic> userQuerySnapshot = firestore.collection('users').where("email" , isEqualTo : post_email).get() as QuerySnapshot<dynamic>;
                    // AsyncSnapshot<List<DocumentSnapshot>> snapshot = userQuerySnapshot.docs as AsyncSnapshot<List<DocumentSnapshot<Object?>>>;
                    // List<DocumentSnapshot> documents1 = snapshot.data!;
                    // final dt = documents1[0];
                    // QuerySnapshot<Map<String, dynamic>> userQuerySnapshot =  firestore.collection('users').where("email" , isEqualTo : post_email).get() as QuerySnapshot<Map<String, dynamic>>;
                    // List<DocumentSnapshot<Map<String, dynamic>>> documomts = userQuerySnapshot.docs;
                    // final dt = documomts[0].data();
                      // Assuming you have the email value in a variable called userEmail



                    // Future<List<QueryDocumentSnapshot<Object?>>> getUser() async {
                    //   QuerySnapshot querySnapshot =
                    //   await firestore.collection('users').where("email" , isEqualTo : post_email).get();
                    //   return querySnapshot.docs;
                    //
                    // }
                    return
                      Column(


                        children: [

                          Material(
                            elevation: 35,
                              borderRadius: BorderRadius.circular(30),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 3),
                              child: Container(

                              decoration: BoxDecoration(
                                  // color: Colors.limeAccent,
                                border: Border.all(
                                  width: 1
                                ),
                                    borderRadius: BorderRadius.circular(20)
                              ),
                              child: Column(

                                  mainAxisAlignment : MainAxisAlignment.center,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 0.5
                                          )
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 7),
                                        Container(

                                           // decoration: BoxDecoration(
                                           //   border: Border(
                                           //     bottom: BorderSide(
                                           //       width: 1
                                           //     )
                                           //   )
                                           // ),

                                          child: IconButton(onPressed: () {
                                            Navigator.push(context , MaterialPageRoute(builder:(context) => UserProfileScreen(email : post_email)));
                                          },
                                             icon: Icon(Icons.account_circle_rounded , size: 37),

                                          ),
                                        ),
                                        Text(

                                          username
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(

                                    // child:
                                    child: Align(


                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          // decoration : BoxDecoration(
                                          //   border: Border.all(width: 2)
                                          //
                                          // ),

                                          //padding: Padding(padding: EdgeInsets.fromLTRB(0, top, right, bottom),),
                                          child: Text(
                                              "   ${data['description']} "
                                          ),

                                        )
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 0,
                                  //       width: 0
                                  // ),
                                Image.network(
                                    data['profile_pic'],
                                    height: 180,
                                    width: 400,
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          width: 0.5
                                        )
                                      )
                                    ),

                                    child: Row(

                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                       IconButton(onPressed: () {
                                         var postID = '${data['description']}_${data['email']}';
                                          onLike(postID);
                                          print("liked");
                                          // setState(() {
                                          //   liked = 1;
                                          // });
                                         liked = 1;

                                       },
                                         icon: (postLikedStatus.contains('${data['description']}_${data['email']}'))?Icon(Icons.thumb_up_alt,
                                             color: Colors.blue):Icon(Icons.thumb_up_alt,
                                             color: Colors.black12)

                                       ),
                                        Text(
                                        data['like'].length.toString()
                                        ),

                                        SizedBox(
                                          width: 20,
                                        ),

                                        IconButton(onPressed: () {

                                          Navigator.push(context, MaterialPageRoute(builder:(context) => CommentScreen(auth.currentUser?.email, '${data['description']}_${data['email']}')));
                                        },
                                          icon: Icon(Icons.comment_bank_rounded,
                                            color: Colors.red,)
                                          // Icons.comment_bank_rounded,
                                          // color: Colors.red,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        IconButton(onPressed: () {
                                        UrlLauncher.launch("tel:+91${usernumber}" as String);

                                        },
                                            icon: Icon(Icons.call))


                                      ],

                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                ],
                              ),
                    ),
                            ),
                          ),
                          SizedBox(height: 15,)
                        ],
                      );

                    },
                );
              }
            },

          ),
        ),
      ),
        bottomNavigationBar: Container(

          decoration: BoxDecoration(
              color: Colors.blueGrey,
            border: Border(
              top: BorderSide(
                width: 2,
              )
            )
          ),
          child: Row(

          children: <Widget> [
            InkWell(onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
            },
              child: Icon(Icons.house_outlined ,
              size: 30 , color: Colors.white,),

            ),

            SizedBox(
              width: 35,
            ),
    InkWell(onTap:(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
    },
    child: Icon(Icons.people_alt_sharp ,
    size: 30 , color: Colors.white,),

    ),

            SizedBox(
              width: 35,
            ),
            InkWell(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyCustomForm()));
            },
            child: Icon(Icons.add_a_photo_outlined , size:30 , color: Colors.white),
    ),
            SizedBox(
              width: 35,
            ),
            InkWell(onTap: (){

            },
            child:Icon(Icons.people_alt_sharp,
    size: 30,color: Colors.white) ),
                SizedBox(
             width: 35,
                           ),
    InkWell(onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => PostListScreen()));
    },

    child:Icon(Icons.save,
    size: 30,color: Colors.white) ),
    SizedBox(
    width: 40,
    ),
    //           ElevatedButton(
    //           child: Text("Refresh"),
    //           onPressed: _refreshScreen,
    // )

    //           onPressed: () {
    //             //     FirebaseAuth.instance.signOut().then((value) {
    //             //           print("SignedOut Successfully ");
    //             // Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
    //
    // });




      ],
          ),
        ),
    //     bottomSheet : Container(
    //       alignment: Alignment.topRight,
    //       margin: EdgeInsets.fromLTRB(0, 90, 0, 0),
    //
    //       child: Row(
    //         children: <Widget>[
    //           InkWell(onTap:(){
    //             Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
    //           },
    //             child: Icon(Icons.person_2_outlined,
    //             size:30),
    //     ),
    //
    //     InkWell(onTap:(){
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
    // },
    // child: Icon(Icons.chat_bubble_rounded,
    // size: 30),
    // ),
    //
    //
    //
    //         ],
    //       ),
    //     ),


    );


    throw UnimplementedError();
  }

}