// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// //
// // class UserProfileScreen extends StatefulWidget{
// // const UserProfileScreen({super.key});
// //
// // @override
// // State<StatefulWidget> createState() => _UserProfileScreenState();
// // // TODO: implement createState
// //
// // }
// //
// // class _UserProfileScreenState extends State<UserProfileScreen>{
// //   late String _name;
// //   late String _email;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchUserData();
// //   }
// //
// //   Future<void> _fetchUserData() async {
// //     final user = FirebaseAuth.instance.currentUser;
// //     final userData =
// //     await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
// //     setState(() {
// //       _name = userData['name'];
// //       _email = userData['email'];
// //     });
// //   }
// //   void _editName() async {
// //     final newName = await showDialog(
// //       context: context,
// //       builder: (context) => _EditFieldDialog(
// //         initialValue: _name,
// //         title: 'Edit Name',
// //       ),
// //     );
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final size = MediaQuery.of(context).size;
// //     return Scaffold(
// //
// //       appBar: AppBar(
// //         title: Text("Profile"),
// //       ),
// //       body: Row(
// //
// //        children: [
// //          Container(
// //            width : size.width / 2,
// //            child: const CircleAvatar(),
// //          ),
// //          Column(
// //
// //
// //          )
// //        ],
// //       ),
// //     );
// //
// //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     // TODO: implement build
// // //     throw UnimplementedError();
// // //   }
// // // }
// // //    // TODO: implement build
// //     throw UnimplementedError();
// //   }
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // TODO: implement build
// //     throw UnimplementedError();
// //   }
// // }
//
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// //
// // class UserProfileScreen extends StatefulWidget{
// //   const UserProfileScreen({super.key});
// //
// //   @override
// //   State<StatefulWidget> createState() => _UserProfileScreenState();
// // // TODO: implement createState
// //
// // }
// //
// // class _UserProfileScreenState extends State<UserProfileScreen> {
// //   final size = MediaQuery.of(context).size;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title : Text("Profile")),
// //       body: Row(
// //          children: [
// //         Container(
// //            width : size.width / 2,
// //            child: const CircleAvatar(),
// //          ),
// //          Column(
// //            children: [
// //
// //            ],
// //
// //           )
// //          ],
// //
// //
// //       ),
// //     );
//
// //     // TODO: implement build
// //     throw UnimplementedError();
// //   }
// // }
//
// // void in
// //   Future<void> _fetchUserData() async {
// //     final user = FirebaseAuth.instance.currentUser;
// //     final userData =
// //     await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
// //     setState(() {
// //       _name = userData['name'];
// //       _email = userData['email'];
// //     });
// //   }
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class UserProfileUI extends StatefulWidget {
//   String data = " ";
//   @override initState(){
//     super.initSate();
//     _fetchUserData();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Profile'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // User profile header
//             Container(
//               padding: EdgeInsets.all(16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   CircleAvatar(
//                     radius: 50,
//                     backgroundImage: AssetImage('assets/images/profile.jpg'),
//                   ),
//                   Column(
//                     children: [
//                       Text(
//                         'Jane Doe',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         '123 followers • 456 following',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       ElevatedButton(
//                         onPressed: () {},
//                         child: Text('Edit Profile'),
//                         style: ElevatedButton.styleFrom(
//                           primary: Colors.blue,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             // User profile body
//             Container(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Bio',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus.',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Posts',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   GridView.builder(
//                     itemCount: 9,
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       mainAxisSpacing: 8,
//                       crossAxisSpacing: 8,
//                     ),
//                     itemBuilder: (context, index) {
//                       return Container(
//                         decoration: BoxDecoration(
//                           // image: DecorationImage(
//                           //   image: AssetImage('assets/images/post$index.jpg'),
//                           //   fit: BoxFit.cover,
//                           // ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:math';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ngoapp/Managers/user_profile_manager.dart';
import 'package:ngoapp/screens/ChatRoom.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileScreen extends StatefulWidget{
  const UserProfileScreen({required this.email});
  final String? email;

  @override
  State<StatefulWidget> createState() => _UserProfileScreenState();
// TODO: implement createState

}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isPressed = false;

  final UserProfileManager _profileManager = UserProfileManager();
  late final CollectionReference usersRef;
  late final Stream<DocumentSnapshot> userStream;

  String data = '';
  String datano = '';
  String link = '';
  String selected_field = '';
  int c = 0;
  List followerdata = [];
  List followingdata = [];
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
String initialText = "Link for your Razor Pay";
bool isEditingText = false;
  final TextEditingController _editingController = TextEditingController();
  List<String> _list = List.generate(100, (index) => 'Item ${index + 1}');
  Future<void> _refreshList() async {


    // simulate a data fetch operation

    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _list = List.generate(10, (index) => 'Item ${index + 1}');
    });
  }

  @override
  void initState() {

    super.initState();



    // usersRef = FirebaseFirestore.instance.collection('users');
    // userStream = usersRef.doc(widget.userId).snapshots();
    getData();
  }
  @override
  void dispose(){
    _editingController.dispose();
    super.dispose();
  }

  void getData() async {
    final user = FirebaseAuth.instance.currentUser;
    String? email = _auth.currentUser!.email;
    DocumentSnapshot snapshot = await _firestore.collection("users").doc(widget.email).get();

      print(email);

    print(snapshot.exists);
    setState(() {
      Map<String, dynamic>? dataMap = snapshot?.data() as Map<String, dynamic>? ;
      // as Map<String, dynamic>?;
      data = dataMap!['name'] as String;
      datano = dataMap!['rNo'] as String ;
      link = dataMap!['link'] as String;

      selected_field = dataMap!['selected_field'] as String;
      print("selected field: ${selected_field}");
      print(dataMap!['following']);
      // c = dataMap!['following'].length as int;
      // Map<String, List>? followerMap = snapshot?.data() as Map<String, List>?;
      // followerdata = followerMap!['followers'] as List;
      // Map<String, List>? followingMap = snapshot?.data() as Map<String, List>?;
      // followingdata = followingMap!['following'] as List;
      // print(data);

    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Colors.black38,
        actions: [
          Container(
            alignment: Alignment.centerRight,
            child: IconButton(onPressed: (){}, icon: Icon(Icons.edit_note_outlined, size: 37)),
          )
          
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // User profile header
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/Images/profile.jpg'),
                  ),
                  SizedBox(
                   width: size.width/8,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: size.height/30,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${data}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height/35),
                      Text(
                        "Followers  .   Following ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Container(alignment: Alignment.bottomCenter,child: Text("123                   234",style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16
                      ),)),

                      SizedBox(height: 20),
                  Row(
                    children: [
                      (_auth.currentUser!.email == widget.email) ?

                      ElevatedButton(
                        onPressed: () {
                        },
                        child: Text('Edit Profile'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ) : ElevatedButton(

                        onPressed: () {

                          var db = FirebaseFirestore.instance;
// Add a new document with a generated ID
                          db.collection("users").doc(widget.email).update({
                            'followers': FieldValue.arrayUnion([_auth.currentUser!.email] )
                          });

// Add a new document with a generated ID
                          db.collection("users").doc(_auth.currentUser!.email).update({
                            'following': FieldValue.arrayUnion([widget.email] )
                          });
                          setState(() {
                            isPressed = true;
                          });

                        },

                        child: isPressed ? Text("Following") : Text("Follow"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width / 12.5,
                      ),
                      ElevatedButton(onPressed: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoomScreen(currentUser: _auth.currentUser?.email, otherUser: widget.email)));
                      }, child: Text("Chat"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),)
                    ],
                  ),

                    ],
                  ),
                ],
              ),
            ),

            // User profile body
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.centerLeft,

              child: Container(
                width: size.width/1.11,


                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (selected_field == "NGO")?Container(
                      child: Text(
                          'NGO Information',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ):SizedBox(height: 0,width: 0,),
                    (selected_field == "NGO")?Container(
                      padding: EdgeInsets.fromLTRB(10, 12, 0, 0),
                      width: MediaQuery.of(context).size.width/1.12,
                      height: MediaQuery.of(context).size.height / 8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1.5,
                            color: Colors.grey,
                          )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'NGO Unique No. : ${datano}',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                          ),

                              SizedBox(height:5),

                              Text(
                                'Website/Insta : ${link}',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,

                                  fontSize: 16,
                                ),

                              ),


                      ],

                      )
                      // child: Text(
                      //   'NGO Unique No. : ${datano} \n\n Website/Insta : ${link}',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.normal,
                      //     fontSize: 14,
                      //   ),
                      // ),
                      // child: Text(
                      //   'NGO Unique No. : ${datano} \n\n Website/Insta : ${link}',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.normal,
                      //     fontSize: 14,
                      //   ),
                      // ),
                    ):(SizedBox(height: 0, width: 0,)),

                    (selected_field == 'NGO')?ElevatedButton(
                      child: new Text('Check Validity'),
                      onPressed: () => launch('https://ngodarpan.gov.in/index.php/search/'),
                    ):SizedBox(height: 0, width: 0),

                    Text(
                      ' Bio',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: size.height / 70),


                    Container(
                      padding: EdgeInsets.fromLTRB(10, 12, 0, 0),
                      width: MediaQuery.of(context).size.width/1.12,
                        height: MediaQuery.of(context).size.height / 15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1.5,
                              color: Colors.grey,
                            )
                        ),
                      child:_editTitleTextField() ,
                    ),
                    SizedBox(height: 8),
                    // GridView.builder(
                    //   itemCount: 9,
                    //   shrinkWrap: true,
                    //   physics: NeverScrollableScrollPhysics(),
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 3,
                    //     mainAxisSpacing: 8,
                    //     crossAxisSpacing: 8,
                    //   ),
                    //   itemBuilder: (context, index) {
                    //     return Container(
                    //       decoration: BoxDecoration(
                    //         image: DecorationImage(
                    //           image: AssetImage('assets/images/post$index.jpg'),
                    //           fit: BoxFit.cover,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),

                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5
            ),
            RefreshIndicator(
              onRefresh: _refreshList,
              child: Container(
                height: 200,
                width: size.width/1.12,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.grey,
                  )
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          child: Icon(Icons.add_a_photo_outlined , size: 40 ),
                      onTap: () {
                        final bio = _editingController.text;
                        void PostQR() async {
                          final image = await ImagePicker().pickImage(
                              source: ImageSource.gallery,
                              maxWidth: 512,
                              maxHeight: 512,
                              imageQuality: 90);
                          var rnd = Random();
                          FirebaseAuth _auth = FirebaseAuth.instance;
                          Reference ref = await FirebaseStorage.instance
                              .ref()
                              .child("${_auth.currentUser?.email}-${rnd.nextInt(
                              100000)}_qrcode.jpg");

                          await ref.putFile(File(image!.path));

                          ref.getDownloadURL().then((value) =>
                              _profileManager.submitPost(
                                bio: bio, qrpic: value));
                        };
                        PostQR();

                      },

                      ),
                      Text("Upload QR-Code" , style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w400

                      ),)
                    ],

                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
  Widget _editTitleTextField() {
    if (isEditingText) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
            width: 2,
            )
          ),
          child: TextField(
            onSubmitted: (newValue){
              setState(() {
                initialText = newValue;
                isEditingText =false;
              });
            },
            autofocus: true,
            controller: _editingController,
          ),
        ),
      );
    }
    return InkWell(
        onTap: () {
      setState(() {
        isEditingText = true;
      });
    },
    child: Text(
    initialText,
    style: TextStyle(
    color: Colors.black,
    fontSize: 18.0,
    ),)
    );
  }
}


