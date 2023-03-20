

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ngoapp/resuable_widgets/reusable_widget.dart';
import 'package:ngoapp/screens/home_screen.dart';
import 'package:ngoapp/screens/singin_screen.dart';
import 'package:ngoapp/screens/Dropdown_box.dart';

import 'Dropdown_box.dart';

class Prop {
  static String name = "" ;
  static String email = "";
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

   get name => _SignUpScreenState().name;




  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

  class _SignUpScreenState extends State<SignUpScreen>{
  // @override
  // Widget build(BuildContext context) {
  //   TODO: implement build
  //   throw UnimplementedError();

    final TextEditingController _locationTextController = TextEditingController();
    final TextEditingController  _typeTextController = TextEditingController();
    final TextEditingController  _usernameTextController = TextEditingController();
  final TextEditingController  _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  // get name => Sign;
  var name;
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
            MyDropdownBox(

              fields: ['Field 1', 'Field 2'],
              onChanged: (value) {

               return value;
              }
              ),
                FloatingActionButton(
                  onPressed: () {
                    print('Selected field: ');
                  },
                  child: Icon(Icons.check),
                ),
                SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter your Location", Icons.person_outline, false,
                    _locationTextController),
                SizedBox(
                  height: 30,
                ),

                signInSignUpButton(context, false , () {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailTextController.text,
                      password: _passwordTextController.text).then((value) {
                        Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen(email: _emailTextController.text.toString())));
                        // Create a new user with a first and last name
                        final user = <String, dynamic>{
                          "name": _usernameTextController.text.toString(),
                          "email":_emailTextController.text.toString(),
                          "status": "unavailable",
                          "followers" : [],
                          "following" : [],
                          "selected_field" : "",
                          "location" : _locationTextController.text.toString()

                        };
                         // final name = _usernameTextController.text.toString();
                         //
                        // Prop obj = new Prop();
                        // // obj.name = _usernameTextController.text.toString();
                        //
                        // obj.setName(_usernameTextController.text.toString());
                        // print("name:${name}");
                        // print("${ _usernameTextController.text.toString()}");

                    var db = FirebaseFirestore.instance;
// Add a new document with a generated ID
                    db.collection("users").doc(_emailTextController.text.toString()).set(user);

                    Prop.name = _usernameTextController.text;
                    Prop.email = _emailTextController.text;

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
class MyDropdownBox extends StatefulWidget {
  final List<String> fields;
  final Function(String) onChanged;



  MyDropdownBox({required this.fields, required this.onChanged});

  @override
  _MyDropdownBoxState createState() => _MyDropdownBoxState();
}

class _MyDropdownBoxState extends State<MyDropdownBox> {
  String? _selectedField;
  CollectionReference fieldsRef = FirebaseFirestore.instance.collection('users');
  _addSelectedFieldToFirestore() async {
    if (_selectedField != null) {
      await fieldsRef.doc('selected_field').set({'value': _selectedField});
    }
  }


  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedField,
      onChanged: (value) {
        setState(() {
          _selectedField = value;

        });
        _addSelectedFieldToFirestore();
      },
      items: widget.fields
          .map((field) => DropdownMenuItem<String>(
        value: field,
        child: Text(field),
      ))
          .toList(),
      decoration: InputDecoration(
        labelText: 'Select a field',
        border: OutlineInputBorder(),
      ),
    );
  }
}

