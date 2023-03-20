

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ngoapp/screens/Chat_screen.dart';
import 'package:ngoapp/screens/Postform_screen.dart';
import 'package:ngoapp/screens/UserProfile_Screen.dart';
import 'package:ngoapp/screens/singin_screen.dart';
import 'package:ngoapp/screens/signup_screen.dart';

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

  List<String> _list = List.generate(100, (index) => 'Item ${index + 1}');
  Future<void> _refreshList() async {
    // simulate a data fetch operation
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _list = List.generate(10, (index) => 'Item ${index + 1}');
    });
  }

  Future<List<QueryDocumentSnapshot<Object?>>> getDocuments() async {
    QuerySnapshot querySnapshot =
    await firestore.collection('posts').where("user_uid" , isEqualTo: auth.currentUser?.uid).get();
    return querySnapshot.docs;
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect Cause'),

        actions: <Widget> [
          IconButton(

            alignment: Alignment.center,
            icon: Icon(Icons.chat_bubble_rounded),
            onPressed: (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));

            },
            iconSize: 35,
            color: Colors.black,

          ),
          SizedBox(
            width: 305,
          ),
          IconButton(
            alignment: Alignment.topLeft,
            icon: Icon(Icons.person_2_outlined),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileScreen(email : widget.email)));
            },
            iconSize: 32,
            color: Colors.black,

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
                    var post_email = data['email'];

                    print(post_email);
                    QuerySnapshot<dynamic> userQuerySnapshot = firestore.collection('users').where("email" , isEqualTo : post_email).get() as QuerySnapshot<dynamic>;
                    AsyncSnapshot<List<DocumentSnapshot>> snapshot = userQuerySnapshot.docs as AsyncSnapshot<List<DocumentSnapshot<Object?>>>;
                    List<DocumentSnapshot> documents1 = snapshot.data!;
                    final dt = documents1[0];
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
                    return Container(

                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2
                        ),
                            borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.account_circle_rounded, size: 30),
                              Text(

                                "${dt!['name']}"
                              )
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              // border: Border.all(
                              //   width: 3
                              // ),
                            ),
                            child: Image.network(
                              data['profile_pic'],
                              height: 160,
                              width: 140,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                                width: 10
                          ),
                          Align(


                            alignment: Alignment.centerLeft,
                              child: Container(
                                // decoration : BoxDecoration(
                                //   border: Border.all(width: 2)
                                //
                                // ),
                                child: Text(

                                    data['description']
                                ),

                              )
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                             Icon(
                               Icons.thumb_up_alt,
                                   color: Colors.blue
                             ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.comment_bank_rounded,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.send_outlined
                              )

                            ],

                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    );
                    },
                );
              }
            },
          ),
        ),
      ),
        bottomNavigationBar: Row(

        children: <Widget> [
          InkWell(onTap:(){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
          },
            child: Icon(Icons.house_outlined ,
            size: 30),

          ),

          SizedBox(
            width: 35,
          ),
    InkWell(onTap:(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
    },
    child: Icon(Icons.people_alt_sharp ,
    size: 30),

    ),

          SizedBox(
            width: 35,
          ),
          InkWell(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MyCustomForm()));
          },
          child: Icon(Icons.add_a_photo_outlined , size:30),
    ),
          SizedBox(
            width: 35,
          ),
          InkWell(onTap: (){

          },
          child:Icon(Icons.people_alt_sharp,
    size: 30,) ),
              SizedBox(
           width: 35,
                         ),
    InkWell(onTap: (){

    },

    child:Icon(Icons.face_2_outlined,
    size: 30,) ),
    SizedBox(
    width: 40,
    ),
            ElevatedButton(
            child: Text("Refresh"),
            onPressed: _refreshScreen,
    )

    //           onPressed: () {
    //             //     FirebaseAuth.instance.signOut().then((value) {
    //             //           print("SignedOut Successfully ");
    //             // Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
    //
    // });




      ],
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