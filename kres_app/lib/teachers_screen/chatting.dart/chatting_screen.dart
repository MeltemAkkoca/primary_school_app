import 'package:flutter/material.dart';
import 'package:meditation_app/models/message.dart';
import 'package:meditation_app/models/user_authentication/database_helper.dart';
import 'package:meditation_app/models/user_authentication/parents.dart';
import 'package:meditation_app/models/user_authentication/teachers.dart';

class ChattingScreen extends StatefulWidget {
  final Teachers teacher;
  final Parents parent;

  ChattingScreen({Key? key, required this.teacher, required this.parent})
      : super(key: key);

  @override
  _ChattingScreenState createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  List<Chatting> messages = [];
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadMessages();
  }

  void loadMessages() async {
    messages = await DatabaseHelper()
        .getMessagesByUser(widget.teacher.userId, widget.parent.userId);
    setState(() {});
  }

  void sendMessage() async {
    var newMessage = Chatting(
      senderId: widget.teacher.userId,
      receiverId: widget.parent.userId,
      text: messageController.text,
    );
    await DatabaseHelper().insertMessages(newMessage);
    messageController.clear();
    loadMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 43, 117, 88),
        title: Text('${widget.parent.userName} ${widget.parent.userSurname}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                bool isSentByMe = message.senderId == widget.teacher.userId;

                return Container(
                  alignment:
                      isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSentByMe ? Colors.blue[100] : Colors.green[100],
                      borderRadius: isSentByMe
                          ? BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15))
                          : BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                    ),
                    child: Text(message.text),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration:
                        InputDecoration(hintText: 'Mesajınızı yazın...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
