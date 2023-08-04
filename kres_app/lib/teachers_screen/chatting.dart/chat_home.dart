import 'package:flutter/material.dart';
import 'package:meditation_app/models/students.dart';
import 'package:meditation_app/models/user_authentication/parents.dart';
import 'package:meditation_app/models/user_authentication/teachers.dart';
import 'package:meditation_app/models/user_authentication/database_helper.dart';
import 'package:meditation_app/teachers_screen/chatting.dart/chatting_screen.dart';

class ChatHomePageScreen extends StatefulWidget {
  final Teachers teacher;
  const ChatHomePageScreen({Key? key, required this.teacher}) : super(key: key);

  @override
  _ChatHomePageScreenState createState() => _ChatHomePageScreenState();
}

class _ChatHomePageScreenState extends State<ChatHomePageScreen> {
  List<Parents> parentsList = [];
  Map<Parents, Students?> parentsWithStudents = {};

  @override
  void initState() {
    super.initState();
    loadParents();
  }

  void loadParents() async {
    parentsList = await DatabaseHelper().getParentsbyTeachers(widget.teacher);
    for (final parent in parentsList) {
      final student = await DatabaseHelper().getStudentsbyParent(parent);
      parentsWithStudents[parent] = student;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 43, 117, 88),
        title: Text('Veliler', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: parentsList.length,
        itemBuilder: (context, index) {
          final parent = parentsList[index];
          final student = parentsWithStudents[parent];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, color: Colors.black),
            ),
            title: Text(
              '${parent.userName} ${parent.userSurname}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${student?.studentFirstName} ${student?.studentLastName}\'ın velisi',
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChattingScreen(
                    teacher: widget.teacher,
                    parent: parent,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
