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
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ngoapp/Managers/Post_manager.dart';
import 'package:ngoapp/resuable_widgets/reusable_widget.dart';
import 'package:ngoapp/screens/UserProfile_Screen.dart';
import 'package:ngoapp/screens/userPost_screen.dart';
import 'package:ngoapp/screens/signup_screen.dart';


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

  var counter = 0;
  void _refreshScreen() {
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
    return Material(
      key: _formKey,




      child: Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget> [

          Row(


           children: [
             Padding(padding: EdgeInsets.fromLTRB(0, 100, 0, 0)),
             InkWell(
                 child: Icon(Icons.account_circle_rounded,size: 40,),
               onTap: (){
                   Navigator.push(context, MaterialPageRoute(
                   builder: (context) => UserProfileScreen(email:Prop.email )));
               },



             ),
             SizedBox(
               width: 10,
             ),
             Text("${Prop.name}")
           ],
          ),
          // logoWidget(
          //   "assets/Images/logo.jpg"
          // ),
          SizedBox(
            height: 50,
          ),
          Container(
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     width: 2
            //   )
            // ),
            child: new TextFormField(
    controller: _postTextController,
    cursorHeight: 30,
    cursorColor: Colors.red,
  minLines: 5,
    maxLines: 10,
    decoration: InputDecoration(

    label: const Center(
      child: Text("Enter some description")
    ),
            border: OutlineInputBorder(),
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

          InkWell(
            child: Icon(Icons.add_a_photo_outlined,
            size : 40,
            color: Colors.black,),
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
                _postManager.submitPost(description: desc , profilepic: value , ));

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => PostListScreen()));

                _refreshScreen();


              }

              PostPic();
              // Navigator.push(context, MaterialPageRoute(
              //     builder: (context) => PostListScreen()));

            },
          ),
          Text("Select an Image"),
          SizedBox(
            height: 50,
          ),


          ButtonTheme(
            minWidth: 200,
            height: 200,
            colorScheme: ColorScheme.dark(
              onBackground: Colors.black,
            ),
            child: ElevatedButton(
              onPressed: () {
                final desc = _postTextController.text;
                _postManager.submitPost(description: desc, profilepic: null);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => PostListScreen()));

                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
                },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}


