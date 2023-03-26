import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ngoapp/screens/userPost_screen.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'Chat_screen.dart';
import 'Comment_screen.dart';
import 'Postform_screen.dart';
import 'UserProfile_Screen.dart';
import 'package:multiselect/multiselect.dart';

class ExploreScreen extends StatefulWidget{
  ExploreScreen({required this.email });
  final String? email ;
  //
  @override
  State<StatefulWidget> createState() => _ExploreScreenState();
// TODO: implement createState
}

class _ExploreScreenState extends State<ExploreScreen>{

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  int _count =0;

  List<String> tags = ['Education' , 'Healthcare' , 'Environmental' , 'Food', 'Social Cause'];


  void _refreshScreen(){
    setState(() {
      _count++;
    });
  }
  Map<String , dynamic>? PostuserMap;
  bool isLoading = false;
  late var post_email ;
  String username = "";
  String usernumber = "";
  // late num usernumber;
  List<String> post_mail= [];
  List<Map<String , dynamic >> user_mail = [];

  Future<void> CollectUsers() async {
    print('Hello from collectUsers!');
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection('users').get();
    print('Query Snapshot of collectUsers: ${querySnapshot}');
    user_mail =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    print('Users List: ${user_mail}');

  }

  String? Compare(postEmail) {

    print('hello from Compare');
    print(user_mail);
    print(postEmail);
    // print('user email : ${user_mail[0]['email']}');
    for(int j = 0; j< user_mail.length ; j++) {
      if(postEmail == user_mail[j]['email']) {
        print('my name : ${user_mail[j]['name']}');
        return (user_mail[j]['name']);

      }
    }
  }

  String? getUserNumber(postEmail) {

    for(int j = 0; j< user_mail.length ; j++) {
      if(postEmail == user_mail[j]['email']) {
        print('my name : ${user_mail[j]['name']}');
        return (user_mail[j]['number']);

      }
    }

  }

  Map<String, dynamic>? getCurrentUser(currentUserEmail) {
    for(int j = 0; j< user_mail.length ; j++) {
      if(currentUserEmail == user_mail[j]['email']) {
        print('my name : ${user_mail[j]['name']}');
        return (user_mail[j]);

      }
    }
  }

  List<String> _list = List.generate(100, (index) => 'Item ${index + 1}');
  Future<void> _refreshList() async {

    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _list = List.generate(10, (index) => 'Item ${index + 1}');
    });
  }

  void onLike(postID) {
    FirebaseFirestore firestorm = FirebaseFirestore.instance;
    final postRef = firestorm.collection("posts").doc(postID);
    postRef.update({"like" : FieldValue.arrayUnion([auth.currentUser?.email])});
  }

  List<String> postLikedStatus = [];
  Future<void> likedStatus(postID) async {
    FirebaseFirestore firestorm = FirebaseFirestore.instance;
    final postRef = firestorm.collection("posts").doc(postID);

    postRef.get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        if(data['like'].contains(auth.currentUser?.email)) {
          postLikedStatus.add(postID);
        }

      },
      onError: (e) => print("Error getting document: $e"),


    );

  }

  int liked = 0;

  List<String> givenTags = ['Education' , 'Healthcare' , 'Environmental' , 'Food', 'Social Cause'];

  Future<List<QueryDocumentSnapshot<Object?>>> getDocuments(List<String> chosedTags) async {
    await CollectUsers();

    Map<String, dynamic>? currentUser  = getCurrentUser(auth.currentUser?.email);
    List<dynamic> currentUserFollowing = currentUser!['following'];
    print(currentUserFollowing);
    List<QuerySnapshot> listQuerySnapShots = [];

    QuerySnapshot querySnapshot =
    await firestore.collection('posts').where("user_uid" , isEqualTo: auth.currentUser?.uid).get();


          QuerySnapshot querySnapshot1 =
          await firestore.collection('posts').where("tags" , arrayContainsAny: chosedTags).get();


          print("inside explore:${querySnapshot1.docs}");

          listQuerySnapShots.add(querySnapshot1);

    List<QueryDocumentSnapshot<Object?>> queryDocs = [];
    for (int i = 0; i < listQuerySnapShots.length; i++) {
      queryDocs.addAll(listQuerySnapShots[i].docs);
    }
    // QueryDocumentSnapshot<Object?> queryDocs;
    //  queryDocs = (querySnapshot1.docs );
    // Map<String, dynamic> documents;

    List<Map<String, dynamic>> documents = [];
    for(int i=0;i<queryDocs.length;i++) {
      documents.add(queryDocs[i].data() as Map<String, dynamic>);
      for(int j = 0; j<documents.length;j++) {
        await likedStatus('${documents[j]['description']}_${documents[j]['email']}');
      }

    }
    return queryDocs;
  }


  //     documents = (queryDocs[0].data() as Map<String, dynamic>);
  //
  //     print("documents inside explore:${documents}");
  //
  //       await likedStatus('${documents['description']}_${documents['email']}');
  //       print(queryDocs);
  //
  //
  //
  //   return queryDocs;
  // }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
        // title: const Text('Connect Cause'),
    backgroundColor: Colors.blueGrey,
    flexibleSpace:Container(
      width: MediaQuery.of(context).size.width / 20,
      color:Colors.white,
      margin: EdgeInsets.fromLTRB(50, 45, 40, 10),
      child: DropDownMultiSelect(
        onChanged: (List<String> x) {
          setState(() {
            tags =x;
          });
        },
        options: ['Education' , 'Healthcare' , 'Environmental' , 'Food', 'Social Cause'],
        selectedValues: tags,
        whenEmpty: 'Select Post Tags',
      ),
    ),
    actions: <Widget> [
    // IconButton(
    //
    // alignment: Alignment.center,
    // icon: Icon(Icons.filter, color: Colors.white),
    // onPressed: (){
    // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
    //
    // },
    // iconSize: 35,
    //
    //
    // ),

    // SizedBox(
    // width: 30,
    // ),
    // IconButton(
    // alignment: Alignment.topLeft,
    // icon: Icon(Icons.sort),
    // onPressed: (){
    // Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfileScreen(email : widget.email)));
    // },
    // iconSize: 32,
    // color: Colors.white,
    //
    // ),



 ],
    ),


    body:
       RefreshIndicator(
      onRefresh: _refreshList,

          child: Container(
                  child: FutureBuilder<List<DocumentSnapshot>>(
                  future: getDocuments(tags),
          builder: (BuildContext context,
          AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
          print("Snapshot in builder : ${snapshot}");
          // CollectUsers();
          print("tags inside body:${tags}");
          if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
          child: CircularProgressIndicator(),
          );
          } else if (snapshot.hasError) {
          return Center(
          child: Text('Error: ${snapshot.error}'),
          );
          } else {
          List<DocumentSnapshot> documents = snapshot.data! as List<DocumentSnapshot<Object?>>;
          print("Snapshotsssss dataaaaa ${snapshot.data!}");
          return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (BuildContext context, int index) {
          final data = documents[index];

          print("data : ${data}");
          print("length : ${documents.length + 1}");
          post_email = data['email'];


          print(post_email);
          // post_mail.add(post_email);
          username = Compare(post_email) as String ;
          usernumber = getUserNumber(post_email)!;
          print(username);
          print(usernumber);

          // QuerySnapshot<dynamic> userQuerySnapshot = firestore.collection('users').where("email" , isEqualTo : post_email).get() as QuerySnapshot<dynamic>;
          // AsyncSnapshot<List<DocumentSnapshot>> snapshot = userQuerySnapshot.docs as AsyncSnapshot<List<DocumentSnapshot<Object?>>>;
          // List<DocumentSnapshot> documents1 = snapshot.data!;
          // final dt = documents1[0];
          // QuerySnapshot<Map<String, dynamic>> userQuerySnapshot =  firestore.collection('users').where("email" , isEqualTo : post_email).get() as QuerySnapshot<Map<String, dynamic>>;
          // List<DocumentSnapshot<Map<String, dynamic>>> documomts = userQuerySnapshot.docs;
          // final dt = documomts[0].data();
          // Assuming you have the email value in a variable called userEmail



          // Future<List<QueryDocumentSnapshot<Object?>>> getUser() async {
          //   QuerySnapshot querySnapshot =
          //   await firestore.collection('users').where("email" , isEqualTo : post_email).get();
          //   return querySnapshot.docs;
          //
          // }
          return
          Column(


          children: [

          Material(
          elevation: 35,
          borderRadius: BorderRadius.circular(30),
          child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 3),
          child: Container(

          decoration: BoxDecoration(
          // color: Colors.limeAccent,
          border: Border.all(
          width: 1
          ),
          borderRadius: BorderRadius.circular(20)
          ),
          child: Column(

          mainAxisAlignment : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          SizedBox(
          height: 5,
          ),
          Container(
          decoration: BoxDecoration(
          border: Border(
          bottom: BorderSide(
          width: 0.5
          )
          ),
          ),
          child: Row(
          children: [
          SizedBox(width: 7),
          Container(

          // decoration: BoxDecoration(
          //   border: Border(
          //     bottom: BorderSide(
          //       width: 1
          //     )
          //   )
          // ),

          child: IconButton(onPressed: () {
          Navigator.push(context , MaterialPageRoute(builder:(context) => UserProfileScreen(email : post_email)));
          },
          icon: Icon(Icons.account_circle_rounded , size: 37),

          ),
          ),
          Text(

          username
          )
          ],
          ),
          ),
          SizedBox(
          height: 5,
          ),
          Container(

          // child:
          child: Align(


          alignment: Alignment.centerLeft,
          child: Container(
          // decoration : BoxDecoration(
          //   border: Border.all(width: 2)
          //
          // ),

          //padding: Padding(padding: EdgeInsets.fromLTRB(0, top, right, bottom),),
          child: Text(
          "   ${data['description']} "
          ),

          )
          ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 70
          ),
          Image.network(
          data['profile_pic'],
          height: MediaQuery.of(context).size.height / 3.5,
            width: MediaQuery.of(context).size.width / 1.11,
          ),

          SizedBox(
          height: 10,
          ),
          Container(
          decoration: BoxDecoration(
          border: Border(
          top: BorderSide(
          width: 0.5
          )
          )
          ),

          child: Row(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          SizedBox(
          width: 10,
          ),
          IconButton(onPressed: () {
          var postID = '${data['description']}_${data['email']}';
          onLike(postID);
          print("liked");
          // setState(() {
          //   liked = 1;
          // });
          liked = 1;

          },
          icon: (postLikedStatus.contains('${data['description']}_${data['email']}'))?Icon(Icons.thumb_up_alt,
          color: Colors.blue):Icon(Icons.thumb_up_alt,
          color: Colors.black12)

          ),
          Text(
          data['like'].length.toString()
          ),

          SizedBox(
          width: 20,
          ),

          IconButton(onPressed: () {

          Navigator.push(context, MaterialPageRoute(builder:(context) => CommentScreen(auth.currentUser?.email, '${data['description']}_${data['email']}')));
          },
          icon: Icon(Icons.comment_bank_rounded,
          color: Colors.red,)
          // Icons.comment_bank_rounded,
          // color: Colors.red,
          ),
          SizedBox(
          width: 20,
          ),
          IconButton(onPressed: () {
          UrlLauncher.launch("tel:+91${usernumber}" as String);

          },
          icon: Icon(Icons.call))


          ],

          ),
          ),
          SizedBox(
          height: 10,
          ),

          ],
          ),
          ),
          ),
          ),
          SizedBox(height: 15,)
          ],
          );

          },
          );
          }
          },

          ),
          ),

      ),
    bottomNavigationBar: Container(
      height: 47,
      padding:  EdgeInsets.fromLTRB(30, 0, 0, 0),

    decoration: BoxDecoration(
    color: Colors.blueGrey,
    border: Border(
    top: BorderSide(
    width: 2,
    )
    )
    ),
    child: Row(

    children: <Widget> [
    InkWell(onTap:(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
    },
    child: Icon(Icons.house_outlined ,
    size: 30 , color: Colors.white,),

    ),

    SizedBox(
    width: 42,
    ),
    InkWell(onTap:(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
    },
    child: Icon(Icons.people_alt_sharp ,
    size: 30 , color: Colors.white,),

    ),

    SizedBox(
    width: 42,
    ),
    InkWell(onTap: (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyCustomForm()));
    },
    child: Icon(Icons.add_a_photo_outlined , size:30 , color: Colors.white),
    ),
    SizedBox(
    width: 42,
    ),
    InkWell(onTap: (){
    // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
    },
    child:Icon(Icons.explore,
    size: 30,color: Colors.white) ),
    SizedBox(
    width: 42,
    ),
    InkWell(onTap: (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => PostListScreen()));
    },

    child:Icon(Icons.save,
    size: 30,color: Colors.white) ),
    SizedBox(
    width: 40,
    ),
    ],
    ),
    ),
    );

    // throw UnimplementedError();
  }

}