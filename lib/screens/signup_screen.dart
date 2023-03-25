

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
    final TextEditingController _numberTextController = TextEditingController();
    final TextEditingController _rNoTextController = TextEditingController();
    final TextEditingController _linkTextController = TextEditingController();

  // get name => Sign;
  var name;
    String selectedValue= "NGO";
    String selectedCity = "Kolkata";
    List<DropdownMenuItem<String>> get dropdownItemsCities{
      List<DropdownMenuItem<String>> menuItems = [
        DropdownMenuItem(child: Text("Bhopal"),value: "Bhopal"),
        DropdownMenuItem(child: Text("Chandigarh"),value: "Chandigarh"),
        DropdownMenuItem(child: Text("Delhi"),value: "Delhi"),
        DropdownMenuItem(child: Text("Mumbai"),value: "Mumbai"),
        DropdownMenuItem(child: Text("Patna"),value: "Patna"),
        DropdownMenuItem(child: Text("Lucknow"),value: "Lucknow"),
        DropdownMenuItem(child: Text("Dehradun"),value: "Dehradun"),
        DropdownMenuItem(child: Text("Jaipur"),value: "Jaipur"),
        DropdownMenuItem(child: Text("Raipur"),value: "Raipur"),
        DropdownMenuItem(child: Text("Ahmedabad"),value: "Ahmedabad"),
        DropdownMenuItem(child: Text("Chennai"),value: "Chennai"),
        DropdownMenuItem(child: Text("Banglore"),value: "Banglore"),
        DropdownMenuItem(child: Text("Hydrabad"),value: "Hydrabad"),
        DropdownMenuItem(child: Text("Kolkata"),value: "Kolkata"),
        DropdownMenuItem(child: Text("Shillong"),value: "Shillong"),
        DropdownMenuItem(child: Text("Aizwal"),value: "Aizwal"),

        // DropdownMenuItem(child: Text("Individual"),value: "Individual"),
        // DropdownMenuItem(child: Text("Brazil"),value: "Brazil"),
        // DropdownMenuItem(child: Text("England"),value: "England"),
      ];
      return menuItems;
    }
    List<DropdownMenuItem<String>> get dropdownItems{
      List<DropdownMenuItem<String>> menuItems = [
        DropdownMenuItem(child: Text("NGO"),value: "NGO"),
        DropdownMenuItem(child: Text("Individual"),value: "Individual"),
        // DropdownMenuItem(child: Text("Brazil"),value: "Brazil"),
        // DropdownMenuItem(child: Text("England"),value: "England"),
      ];
      return menuItems;
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
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
                .height * 0.07, 20, 0),
            child: Column(
              children: <Widget>[
                // Container(
                //   alignment: Alignment.topLeft,
                //   child: Text("Get Started!",
                //       style: TextStyle(color: Colors.white ,
                //         fontSize: 28 , fontStyle: FontStyle.normal , fontWeight: FontWeight.w500,)
                // ),
                Row(
                  // alignment: Alignment.topRight,
                  children: [
                    Text("Get Started!",
                    style: TextStyle(color: Colors.white ,
                      fontSize: 40 , fontStyle: FontStyle.normal , fontWeight: FontWeight.w500,)
              ),

                    SizedBox(
                      width: 30
                      ,
                    ),


                    Image(
              height: 100,
              width: 100,
              image: AssetImage("assets/Images/gudda.png"),
              fit: BoxFit.cover,
            ),
                  ],
          ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Create New Account...",
                      style: TextStyle(color: Colors.white ,
                        fontSize: 16 , fontStyle: FontStyle.normal , fontWeight: FontWeight.w400,)
                  ),
                ),


                //logoWidget("assets/Images/logo.jpg"),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Username/NGO name", Icons.person_outline, false, false,
                    _usernameTextController),


                SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter Mail ID", Icons.person_outline, false, false,
                    _emailTextController),
                SizedBox(
                  height: 30,
                ),

                reusableTextField("Enter Phone No.", Icons.call, false, false,
                    _numberTextController),
                SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true, false,
                    _passwordTextController),
                SizedBox(
                  height: 30,
                ),
            // MyDropdownBox(
            //
            //   fields: ['Are you an indivisual?', 'Are you an NGO?'],
            //   onChanged: (value) {
            //         print("Value in signup ${value}");
            //    return value;
            //   }
            //   ),
            //     DropdownButton(
            //         value: selectedValue,
            //         onChanged: (String? newValue){
            //           setState(() {
            //             selectedValue = newValue!;
            //           });
            //         },
            //         items: dropdownItems
            //     ),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(width: 0 , style: BorderStyle.none),
                      ),
                        prefixIcon: Icon(
                          Icons.account_circle_rounded,
                          color: Colors.white70,
                        ),
                      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(width: 0 , style: BorderStyle.none),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                    ),
                    style: TextStyle(color: Colors.white),
                    dropdownColor: Colors.blue.withOpacity(0.8),
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: dropdownItems),
                // FloatingActionButton(
                //   onPressed: () {
                //     print('Selected field: ');
                //   },
                //   child: Icon(Icons.check),
                // ),
                SizedBox(
                  height : 25
                ),

                (selectedValue == 'NGO')?
                (reusableTextField("Enter NGO registration no.", Icons.info_outline, false, false, _rNoTextController)):SizedBox(height: 0),

                (selectedValue == 'NGO')?
                (SizedBox(height: 25)):SizedBox(height: 0),

                (selectedValue == 'NGO')?
                reusableTextField("Enter Website/Insta Link", Icons.insert_link_outlined, false, true, _linkTextController):SizedBox(height: 0),

                (selectedValue == 'NGO')?
                (SizedBox(height: 25)):SizedBox(height: 0),

                DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(width: 0 , style: BorderStyle.none),
                      ),
                      prefixIcon: Icon(
                        Icons.account_circle_rounded,
                        color: Colors.white70,
                      ),
                      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(width: 0 , style: BorderStyle.none),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                    ),
                    style: TextStyle(color: Colors.white),
                    dropdownColor: Colors.blue.withOpacity(0.8),
                    value: selectedCity,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCity = newValue!;
                      });
                    },
                    items: dropdownItemsCities),
                // SizedBox(
                //   height: 30,
                // ),
                // reusableTextField("Enter your Location", Icons.person_outline, false,
                //     _locationTextController),
                // SizedBox(
                //   height: 30,
                // ),

                signInSignUpButton(context, false , () {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailTextController.text,
                      password: _passwordTextController.text).then((value) {
                        Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen(email: _emailTextController.text.toString())));
                        // Create a new user with a first and last name

                        final user = <String, dynamic>{
                          "name": _usernameTextController.text.toString(),
                          "email":_emailTextController.text.toString(),
                          "number" : _numberTextController.text,
                          "status": "unavailable",
                          "followers" : [],
                          "following" : [],
                          "selected_field" :  selectedValue,
                          "location" : selectedCity,
                          "rNo" : (selectedValue == 'NGO')?_rNoTextController.text.toString():null,
                          "link" : (selectedValue == 'NGO')?_linkTextController.text.toString():null,


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


