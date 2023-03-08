

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ngoapp/screens/Chat_screen.dart';
import 'package:ngoapp/screens/Postform_screen.dart';
import 'package:ngoapp/screens/UserProfile_Screen.dart';
import 'package:ngoapp/screens/singin_screen.dart';

class HomeScreen extends StatefulWidget{
  HomeScreen({required this.email});
  final String email ;
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
// TODO: implement createState

}

class _HomeScreenState extends State<HomeScreen>{


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
        bottomNavigationBar: Align(

          alignment: Alignment.bottomRight,

          child:Row(

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
    width: 45,
    ),
              ElevatedButton(
              child: Text("Logout"),

                onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                            print("SignedOut Successfully ");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
    });

    },
    ),


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