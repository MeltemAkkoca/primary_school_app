import 'package:flutter/material.dart';
import 'package:meditation_app/models/message.dart';
import 'package:meditation_app/models/user_authentication/database_helper.dart';
import 'package:meditation_app/models/user_authentication/parents.dart';
import 'package:meditation_app/models/user_authentication/teachers.dart';

class ParentChattingScreen extends StatefulWidget {
  final Parents parent;

  ParentChattingScreen({Key? key, required this.parent}) : super(key: key);

  @override
  _ParentChattingScreenState createState() => _ParentChattingScreenState();
}

class _ParentChattingScreenState extends State<ParentChattingScreen> {
  List<Chatting> messages = [];
  final TextEditingController messageController = TextEditingController();
  Teachers? teacher;

  @override
  void initState() {
    super.initState();
    loadTeacherAndMessages();
  }

  Future<void> loadTeacherAndMessages() async {
    teacher = await DatabaseHelper().getTeacherByParent(widget.parent);
    loadMessages();
  }

  void loadMessages() async {
    if (teacher != null) {
      messages = await DatabaseHelper()
          .getMessagesByUser(widget.parent.userId, teacher!.userId);
      setState(() {});
    }
  }

  void sendMessage() async {
    if (teacher != null) {
      var newMessage = Chatting(
        senderId: widget.parent.userId,
        receiverId: teacher!.userId,
        text: messageController.text,
      );
      await DatabaseHelper().insertMessages(newMessage);
      messageController.clear();
      loadMessages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 43, 117, 88),
        title: Text('${teacher?.userName} ${teacher?.userSurname}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                bool isSentByMe = message.senderId == widget.parent.userId;

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
