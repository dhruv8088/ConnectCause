import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatRoomScreen extends StatefulWidget{
const ChatRoomScreen({super.key , required this.currentUser , required this.otherUser});
final currentUser;
final otherUser;

@override
State<StatefulWidget> createState() => _ChatRoomScreenState();
// TODO: implement createState

}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  late Stream<QuerySnapshot> _chatStream;
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    String? chatId = getChatId(widget.currentUser, widget.otherUser);
    _chatStream = FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
    _messageController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: _chatStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Loading...');
                  }
                  List<QueryDocumentSnapshot<Object?>> messages = snapshot.data!.docs;
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      QueryDocumentSnapshot<Object?> message = messages[index];
                      bool isMe = message['senderId'] == widget.currentUser;
                      return Align(
                        alignment: isMe ? Alignment.centerRight : Alignment
                            .centerLeft,
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.symmetric(vertical: 10.0,
                              horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue[100] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            message['text'],
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      );
                    },
                  );
                }
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                FloatingActionButton(
                  onPressed: () {
                    if (_messageController.text.trim().isNotEmpty) {
                      String? chatId = getChatId(widget.currentUser, widget.otherUser);
                      FirebaseFirestore.instance
                          .collection('chatRoom')
                          .doc(chatId)
                          .collection('messages')
                          .add({
                        'text': _messageController.text.trim(),
                        'senderId': widget.currentUser,
                        'receiverId': widget.otherUser,
                        'timestamp': DateTime.now(),
                      });
                      _messageController.clear();
                    }
                  },
                  child: Icon(Icons.send),
                ),
              ],
            ),
          )
        ],
      ),


    );

    // TODO: implement build
    throw UnimplementedError();
  }


  String? getChatId(String userId1, String userId2) {
    if (userId1.compareTo(userId2) < 0) {
      return '$userId1-$userId2';
    }
    else {
      return '$userId2-$userId1';
    }
  }
}
