

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ngoapp/resuable_widgets/reusable_widget.dart';
import 'package:ngoapp/screens/home_screen.dart';
import 'package:ngoapp/screens/singin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});


  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

  class _SignUpScreenState extends State<SignUpScreen>{
  // @override
  // Widget build(BuildContext context) {
  //   TODO: implement build
  //   throw UnimplementedError();
    final TextEditingController  _usernameTextController = TextEditingController();
  final TextEditingController  _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.blue,
          // height: 900.0,
          // width : 900,0
        ),
        height: 900.0,
        width: 900.0,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery
                .of(context)
                .size
                .height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                //logoWidget("assets/Images/logo.jpg"),
                SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter Username", Icons.person_outline, false,
                    _usernameTextController),
                SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter Mail ID", Icons.person_outline, false,
                    _emailTextController),
                SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, false,
                    _passwordTextController),
                SizedBox(
                  height: 30,
                ),
                signInSignUpButton(context, false , () {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailTextController.text,
                      password: _passwordTextController.text).then((value) {
                        123Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                      }).onError((error, stackTrace) {
                     print("Error ${error.toString()}") ;
                  });

                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}