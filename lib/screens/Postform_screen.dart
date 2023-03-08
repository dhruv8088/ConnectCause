// import 'package:flutter/material.dart';
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

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ngoapp/Managers/Post_manager.dart';
import 'package:ngoapp/screens/userPost_screen.dart';

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
        body: const MyCustomForm(),
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
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget> [
          new Expanded(child:
              new Padding(
                padding: EdgeInsets.fromLTRB(0, 220, 0, 0),
      child: new TextFormField(
    controller: _postTextController,
    decoration: InputDecoration(
    labelText: "Enter some text",
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

              )
          ),


      InkWell(
        child: Icon(Icons.post_add_outlined),


      ),

          Padding(
            padding: const EdgeInsets.fromLTRB(150, 0, 0, 200),

            child: ElevatedButton(
              onPressed: () {
                final desc = _postTextController.text;
                _postManager.submitPost(description: desc);
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

