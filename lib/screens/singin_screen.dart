//import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ngoapp/resuable_widgets/reusable_widget.dart';
import 'package:ngoapp/screens/singin_screen.dart';
import 'package:ngoapp/utils/colors_utils.dart';
import 'package:ngoapp/screens/signup_screen.dart';
import 'package:ngoapp/screens/home_screen.dart';

class SignInScreen extends StatefulWidget{
  const SignInScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignInScreenState();
    // TODO: implement createState

}

class _SignInScreenState extends State<SignInScreen>{
  TextEditingController  _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            color:Colors.blue,
            // height: 900.0,
            // width : 900,0
            ),
        height: 900.0,
        width : 900.0,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,MediaQuery.of(context).size.height * 0.2 , 20 , 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/Images/logo.jpg"),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Username", Icons.person_outline, false, _emailTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, false, _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context , true , () {
                    FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailTextController.text,
                        password: _passwordTextController.text).then((value){
                          print("SIgnedIN successfully");
                          Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                        });



                }),
                SignUpoption(context)
              ],
            ),
            ),
          ),
        ),
        );


    }
  }



  Row SignUpoption(BuildContext context){
    return Row(
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
       const Text("Don't have an account",
            style: TextStyle(color: Colors.white70)),
      GestureDetector(
          onTap: () {
              Navigator.push(context ,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
    },
          child: const Text(
            "Sign UP",
            style: TextStyle(color:Colors.white ,fontWeight: FontWeight.bold),
          ),

       )
     ],
    );
}



