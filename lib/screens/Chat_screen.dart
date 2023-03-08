import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ngoapp/screens/ChatRoom.dart';
import 'package:ngoapp/screens/UserProfile_Screen.dart';

class ChatScreen extends StatefulWidget{
  const ChatScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChatScreenState();
// TODO: implement createState

}

class _ChatScreenState extends State<ChatScreen>{
 bool isLoading = false;
 final TextEditingController _search = TextEditingController();
  Map<String , dynamic>? userMap;
 final FirebaseAuth _auth = FirebaseAuth.instance;




 void onSearch() async {

   FirebaseFirestore firestorm = FirebaseFirestore.instance;
   setState(() {
     isLoading = true;
   });
   await firestorm.collection('users').
   where("email", isEqualTo: _search.text.toString()).
   get().then((value) {
     setState(() {
       userMap = value.docs[0].data();
       isLoading = false;
     });
     if (kDebugMode) {
       print(userMap);
     }
   });

 }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final size = MediaQuery.of(context).size;
    return Scaffold(
    appBar:AppBar(
        title:Text("Chats"),
    ),
      body: isLoading
      ?Center(
        child: Container(
          height: size.height / 20,
          width: size.height / 20,
            child: CircularProgressIndicator(),
        ),
      ):Column(
        children: [
          SizedBox(
            height: size.height / 20,

          ),
          SizedBox(
            height: size.height / 14,
            width: size.width,
            child: Container(
              height: size.height / 14,
              width: size.width / 1.15,
                child: TextField(
                  controller: _search,
                    decoration: InputDecoration(
                      hintText: "Search",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                    )
                )
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: onSearch, child: const Text("Search")),

           userMap!=null?ListTile(
            onTap: () {
                // print(_auth.currentUser!.displayName!);
                // print(userMap!['name']);
                String roomId =  userMap!['name'];

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserProfileScreen(email: _search.text.toString())));


            },
             leading:Icon( Icons.account_box , color: Colors.black,),
            title : Text(userMap?['name']),
            subtitle: Text(userMap?['email']),
             trailing: Icon(Icons.chat_bubble_outlined , color:Colors.black),
          ):Container(),


        ],

      ),

    );
    throw UnimplementedError();
  }

  //
  // Widget chatTile(Size size){
  //  return Container(
  //    height: size.height / 12,
  //    width : size.width / 1.2,
  //    child: Row(
  //      children: [
  //
  //      ],
  //    ),
  //  );
  // }
}
// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
//   Map<String, dynamic>? userMap;
//   bool isLoading = false;
//   final TextEditingController _search = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance!.addObserver(this);
//     setStatus("Online");
//   }
//
//   void setStatus(String status) async {
//     await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
//       "status": status,
//     });
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       // online
//       setStatus("Online");
//     } else {
//       // offline
//       setStatus("Offline");
//     }
//   }
//
//   String chatRoomId(String user1, String user2) {
//     if (user1[0].toLowerCase().codeUnits[0] >
//         user2[0].toLowerCase().codeUnits[0]) {
//       return "$user1$user2";
//     } else {
//       return "$user2$user1";
//     }
//   }
//
//   void onSearch() async {
//     FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//     setState(() {
//       isLoading = true;
//     });
//
//     await _firestore
//         .collection('users')
//         .where("email", isEqualTo: _search.text)
//         .get()
//         .then((value) {
//       setState(() {
//         userMap = value.docs[0].data();
//         isLoading = false;
//       });
//       print(userMap);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home Screen"),
//         actions: [
//           IconButton(icon: Icon(Icons.logout), onPressed: () {})
//         ],
//       ),
//       body: isLoading
//           ? Center(
//         child: Container(
//           height: size.height / 20,
//           width: size.height / 20,
//           child: CircularProgressIndicator(),
//         ),
//       )
//           : Column(
//         children: [
//           SizedBox(
//             height: size.height / 20,
//           ),
//           Container(
//             height: size.height / 14,
//             width: size.width,
//             alignment: Alignment.center,
//             child: Container(
//               height: size.height / 14,
//               width: size.width / 1.15,
//               child: TextField(
//                 controller: _search,
//                 decoration: InputDecoration(
//                   hintText: "Search",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: size.height / 50,
//           ),
//           ElevatedButton(
//             onPressed: onSearch,
//             child: Text("Search"),
//           ),
//           SizedBox(
//             height: size.height / 30,
//           ),
//           userMap != null
//               ? ListTile(
//             onTap: () {
//               // String roomId = chatRoomId(
//               //     _auth.currentUser!.displayName!,
//               //     userMap!['name']);
//
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (_) => ChatRoom(
//                     chatRoomId: "${userMap!['name']}"
//                    ,
//                   ),
//                 ),
//               );
//             },
//             leading: Icon(Icons.account_box, color: Colors.black),
//             title: Text(
//               userMap!['name'],
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 17,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             subtitle: Text(userMap!['email']),
//             trailing: Icon(Icons.chat, color: Colors.black),
//           )
//               : Container(),
//         ],
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   child: Icon(Icons.group),
//       //   onPressed: () => Navigator.of(context).push(
//       //     MaterialPageRoute(
//       //       builder: (_) => GroupChatHomeScreen(),
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }