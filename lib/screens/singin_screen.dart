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
            color:Colors.black,
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
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                Container(

                  child: Image(
                    height: 200,
                    width: 200,
                    image: AssetImage("assets/Images/guylog.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Welcome Back!",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white ,
                  fontSize: 28 , fontStyle: FontStyle.normal , fontWeight: FontWeight.w500),


                ),

                Container(
                  height: 40,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Welcome back"),
                  ),


                ),
                SizedBox(
                  height: 5,
                ),
                reusableTextField("Enter Username", Icons.person_outline, false, false, _emailTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, false, false, _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context , true , () {
                    FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailTextController.text,
                        password: _passwordTextController.text).then((value){
                          print("SIgnedIN successfully");
                          Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen(email: _emailTextController.text.toString(),)));
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



