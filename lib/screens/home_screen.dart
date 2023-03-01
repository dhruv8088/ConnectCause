

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ngoapp/screens/Chat_screen.dart';
import 'package:ngoapp/screens/singin_screen.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
// TODO: implement createState

}

class _HomeScreenState extends State<HomeScreen>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Align(

          alignment: Alignment.bottomRight,
          child:Row(
          children: <Widget> [
            ElevatedButton(
            child: Text("Logout"),
          onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              print("SignedOut Successfully ");
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
            });

            },
          ),
            ElevatedButton(onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                        },
                child: Text("Chat"))
      ],
          ),
        ),

    );

    throw UnimplementedError();
  }

}