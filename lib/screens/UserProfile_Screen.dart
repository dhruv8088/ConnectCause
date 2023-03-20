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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ngoapp/screens/ChatRoom.dart';

class UserProfileScreen extends StatefulWidget{
  const UserProfileScreen({required this.email});
  final String email;

  @override
  State<StatefulWidget> createState() => _UserProfileScreenState();
// TODO: implement createState

}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isPressed = false;
  late final CollectionReference usersRef;
  late final Stream<DocumentSnapshot> userStream;
  String data = '';
  int c = 0;
  List followerdata = [];
  List followingdata = [];
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();

    // usersRef = FirebaseFirestore.instance.collection('users');
    // userStream = usersRef.doc(widget.userId).snapshots();
    getData();
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

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // User profile header
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/Images/profile.jpg'),
                  ),
                  Column(
                    children: [
                      Text(
                        "${data}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Followers 123 . Following 134",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8),
                  (_auth.currentUser!.email == widget.email) ?
                      ElevatedButton(
                        onPressed: () {
                        },
                        child: Text('Edit Profile'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
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
                      ElevatedButton(onPressed: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoomScreen(currentUser: _auth.currentUser?.email, otherUser: widget.email)));
                      }, child: Text("Chat"),
                        style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),)
                    ],
                  ),
                ],
              ),
            ),
            // User profile body
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bio',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Text(
                  //   'Posts',
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 16,
                  //   ),
                  // ),
                  SizedBox(height: 8),
                  GridView.builder(
                    itemCount: 9,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/post$index.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}