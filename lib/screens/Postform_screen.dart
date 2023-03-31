//import 'package:flutter/material.dart';
//
// // Define a custom Form widget.
// class MyCustomForm extends StatefulWidget {
//   const MyCustomForm({super.key});
//
//   @override
//   MyCustomFormState createState() {
//     return MyCustomFormState();
//   }
// }
//
// // Define a corresponding State class.
// // This class holds data related to the form.
// class MyCustomFormState extends State<MyCustomForm> {
//   // Create a global key that uniquely identifies the Form widget
//   // and allows validation of the form.
//   //
//   // Note: This is a `GlobalKey<FormState>`,
//   // not a GlobalKey<MyCustomFormState>.
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     // Build a Form widget using the _formKey created above.
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: <Widget>[
//           TextFormField(
//             decoration: InputDecoration(
//               labelText: 'Enter text',
//             ),
//             validator: (value) {
//               if(value!=null){
//                 if (value.isEmpty) {
//                   return 'Please enter your name';
//                 }
//                 return null;
//               }
//
//             },
//             onSaved: (value) {
//               // Do something with the value entered by the user
//             },
//           )
//           // Add TextFormFields and ElevatedButton here.
//         ],
//       ),
//     );
//   }
// }






// import 'dart:html';

import 'dart:io';
import 'dart:math';
// import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ngoapp/Managers/Post_manager.dart';
import 'package:ngoapp/resuable_widgets/reusable_widget.dart';
import 'package:ngoapp/screens/UserProfile_Screen.dart';
import 'package:ngoapp/screens/userPost_screen.dart';
import 'package:ngoapp/screens/signup_screen.dart';
import 'package:multiselect/multiselect.dart';

import 'Chat_screen.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation Demo';


    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  // MyCustomForm(this.email);
  //
  const MyCustomForm({super.key});


  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  final PostManager _postManager = PostManager();
  final TextEditingController  _postTextController = TextEditingController();
  final fcmToken = FirebaseMessaging.instance.getToken();
  List<String> tags = [];

  var counter = 0;
  void _refreshScreen() {
    print("FCM TOKENNNNNNNNNNN${fcmToken}");
    setState(() {
      counter++;
    });
  }




  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();



@override
void dispose(){
  _postTextController.dispose();
  super.dispose();
}



  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    late String desc ;
    // print("email in post form screen:${widget.email}");
    return Material(


      key: _formKey,




      child: Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget> [
         AppBar(
            title: const Text('Add Post'),
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
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileScreen(email : widget.email)));
                },
                iconSize: 32,
                color: Colors.white,

              ),

            ],
          ),

          // Row(
          //
          //
          //  children: [
          //    Padding(padding: EdgeInsets.fromLTRB(0, 100, 0, 0)),
          //    InkWell(
          //        child: Icon(Icons.account_circle_rounded,size: 40,),
          //      onTap: (){
          //          Navigator.push(context, MaterialPageRoute(
          //          builder: (context) => UserProfileScreen(email:Prop.email )));
          //      },
          //
          //
          //
          //    ),
          //    SizedBox(
          //      width: 10,
          //    ),
          //    Text("${Prop.name}")
          //  ],
          // ),
          // logoWidget(
          //   "assets/Images/logo.jpg"
          // ),
          SizedBox(
            height: 30,
          ),
          // Container(
          //   margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          //   decoration: BoxDecoration(
          //       border: Border(
          //         bottom: BorderSide(width: 2.0, color : Colors.black26)
          //       )
          //   ),
          //
          //   child : Row(
          //     children: [
          //       Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 2)),
          //       Text("Add Post",
          //           style : TextStyle(fontWeight: FontWeight.bold, fontSize: 30))
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, //color of border
                  width: 2, //width of border
                ),
                borderRadius: BorderRadius.circular(5)
            ),

            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: DropDownMultiSelect(
              onChanged: (List<String> x) {
                setState(() {
                  tags =x;
                });
              },
              options: ['Education'

                , 'Healthcare', 'Environmental' , 'Food', 'Social Cause'],
              selectedValues: tags,
              whenEmpty: 'Select Post Tags',
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 12,
          ),
          Container(


            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, //color of border
                  width: 2, //width of border
                ),
                borderRadius: BorderRadius.circular(5)
            ),

            child: new TextFormField(
          controller: _postTextController,
          cursorHeight: 30,
          cursorColor: Colors.red,



        minLines: 5,
          maxLines: 10,
          decoration: InputDecoration(


          label: const Center(
            child: Text("Enter some description", style: TextStyle(fontSize: 20,color: Colors.black),)
          ),
                  border: OutlineInputBorder(borderSide : BorderSide.none
                  ),
          ),
          onSaved :(value){
                  desc = value!;
                  print(desc);
          },
          // The validator receives the text that the user has entered.
          validator: (value) {
          if (value == null || value.isEmpty) {
          return 'Please enter some text';
          }
          return null;
          },
          ),
          ),
          SizedBox(height: 20),

          Container(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),

            child: InkWell(
              child: Row(

                children: [
                  Icon(Icons.add_a_photo_outlined,
                    size : 30,
                    color: Colors.black,),
                  SizedBox(
                    width: 20
                  ),
                  Text("Select an Image",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),),

                ],
              ),

              onTap: (){
                final desc = _postTextController.text;
                void PostPic() async {

                  final image = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 512,
                      maxHeight: 512,
                      imageQuality: 90);
                  var rnd = Random();
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  FirebaseFirestore _firestore = FirebaseFirestore.instance;
                  Reference ref = await FirebaseStorage.instance
                      .ref()
                      .child("${_auth.currentUser?.email}-${rnd.nextInt(100000)}_profile.jpg");

                  await ref.putFile(File(image!.path));

                  ref.getDownloadURL().then((value) =>
                  _postManager.submitPost(description: desc , profilepic: value , tags:tags));


// Add a new comment to the "comments" subcollection

                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => PostListScreen()));

                  _refreshScreen();


                }

                PostPic();
                // Navigator.push(context, MaterialPageRoute(
                //     builder: (context) => PostListScreen()));

              },
            ),
          ),

          SizedBox(
            height: 50,
          ),


          SizedBox(
            height: 50,
            width: 350,

            child: ElevatedButton(
              onPressed: () {

                },
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(31, 59, 77, 100)

              ),
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}


