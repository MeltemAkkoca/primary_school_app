import 'package:flutter/material.dart';
import 'package:meditation_app/endofday_screen/widgets/endofday_widgets.dart';
import 'package:meditation_app/models/end_of_day.dart';
import 'package:meditation_app/models/user_authentication/teachers.dart';
import 'package:meditation_app/models/user_authentication/database_helper.dart';
import 'package:meditation_app/teachers_screen/t_endofday/save_and_edit_endofDay.dart';

import '../../models/students.dart';

class TeacherEndofDayScreen extends StatefulWidget {
  final Teachers teacher;

  const TeacherEndofDayScreen({Key? key, required this.teacher})
      : super(key: key);

  @override
  _TeacherEndofDayScreenState createState() => _TeacherEndofDayScreenState();
}

class _TeacherEndofDayScreenState extends State<TeacherEndofDayScreen> {
  List<EndofDay> endofDay = [];

  @override
  void initState() {
    super.initState();
    _loadendofDayStudents();
  }

  _loadendofDayStudents() async {
    endofDay =
        await DatabaseHelper().loadendofDayStudents(widget.teacher.className);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gün Sonu'),
        backgroundColor: Color.fromARGB(255, 43, 117, 88),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewEventScreen(teacher: widget.teacher),
            ),
          ).then((value) => _loadendofDayStudents());
        },
        tooltip: 'Yeni Gün Sonu Değerlendirmesi Ekle',
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color.fromARGB(255, 43, 117, 88),
      ),
      body: endofDay.isEmpty
          ? Center(
              child: Text(
                  'Hiç gün sonu değerlendirilmesi girilmemiş, lütfen gün sonu değerlendirmesi ekleyin.'))
          : ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: endofDay.length,
              itemBuilder: (context, int index) {
                return FutureBuilder<Students?>(
                  future:
                      DatabaseHelper().getStudent(endofDay[index].studentId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final a = snapshot.data!;
                      return Container(
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFF4F6F7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    a.studentFirstName +
                                        " " +
                                        a.studentLastName,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  AssignmentDetailRow(
                                    title: 'Kahvaltı',
                                    statusValue: endofDay[index].breakfast,
                                    imageAsset: _getImageAsset(
                                        endofDay[index].breakfast),
                                  ),
                                  AssignmentDetailRow(
                                    title: 'Öğlen Yemeği',
                                    statusValue: endofDay[index].lunch,
                                    imageAsset:
                                        _getImageAsset(endofDay[index].lunch),
                                  ),
                                  AssignmentDetailRow(
                                    title: 'Uyku',
                                    statusValue: endofDay[index].sleep,
                                    imageAsset:
                                        _getImageAsset(endofDay[index].sleep),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  NewEventScreen(
                                                teacher: widget.teacher,
                                                endOfDay: endofDay[index],
                                              ),
                                            ),
                                          ).then((value) =>
                                              _loadendofDayStudents());
                                        },
                                        icon: Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          if (endofDay[index].studentId !=
                                              "null") {
                                            DatabaseHelper()
                                                .deleteEndofDayStudent(
                                                    endofDay[index].studentId!);
                                            _loadendofDayStudents();
                                          } else {
                                            print('Student ID bulunamadı.');
                                          }
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Text('Öğrenci bulunamadı.');
                    }
                  },
                );
              },
            ),
    );
  }

  String _getImageAsset(String status) {
    switch (status) {
      case 'iyi':
        return 'assets/iyi.png';
      case 'orta':
        return 'assets/orta.png';
      case 'kötü':
        return 'assets/kötü.png';
      default:
        return 'assets/default.png'; // Default image path if no match found
    }
  }
}
