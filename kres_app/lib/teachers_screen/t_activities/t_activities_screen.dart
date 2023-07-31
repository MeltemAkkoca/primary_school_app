import 'package:flutter/material.dart';
import 'package:meditation_app/models/etkinlikler.dart';
import 'package:meditation_app/models/user_authentication/teachers.dart';
import 'package:meditation_app/models/user_authentication/database_helper.dart';
import 'package:meditation_app/teachers_screen/t_activities/t_activities_widgets/t_activities_widgets.dart';

import '../../activities_screen/widgets/activities_widgets.dart';

class TeacherAssignmentScreen extends StatefulWidget {
  final Teachers teacher;

  const TeacherAssignmentScreen({Key? key, required this.teacher})
      : super(key: key);

  @override
  _TeacherAssignmentScreenState createState() =>
      _TeacherAssignmentScreenState();
}

class _TeacherAssignmentScreenState extends State<TeacherAssignmentScreen> {
  List<Etkinlikler> etkinlikler = [];

  @override
  void initState() {
    super.initState();
    _loadEtkinlikler();
  }

  _loadEtkinlikler() async {
    etkinlikler =
        await DatabaseHelper().loadEtkinlikler(widget.teacher.className);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Etkinlikler'),
        backgroundColor: Color.fromARGB(255, 43, 117, 88),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewEventScreen(teacher: widget.teacher),
            ),
          ).then((value) => _loadEtkinlikler());
        },
        tooltip: 'Yeni Etkinlik Ekle',
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color.fromARGB(255, 85, 120, 106),
      ),
      body: etkinlikler.isEmpty
          ? Center(child: Text('Etkinlik yok, lütfen bir etkinlik ekleyin.'))
          : ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: etkinlikler.length,
              itemBuilder: (context, int index) {
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
                            Container(
                              width: 200,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 43, 117, 88)
                                    .withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  etkinlikler[index].eventName,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              etkinlikler[index].description,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w900,
                                  ),
                            ),
                            SizedBox(height: 10),
                            AssignmentDetailRow(
                              title: 'Başlangıç zamanı',
                              statusValue: etkinlikler[index].startTime,
                            ),
                            SizedBox(height: 10),
                            AssignmentDetailRow(
                              title: 'Bitiş zamanı',
                              statusValue: etkinlikler[index].endTime,
                            ),
                            SizedBox(height: 10),
                            AssignmentDetailRow(
                              title: 'Durum',
                              statusValue: etkinlikler[index].eventStatus,
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NewEventScreen(
                                          teacher: widget.teacher,
                                          event: etkinlikler[index],
                                        ),
                                      ),
                                    ).then((value) => _loadEtkinlikler());
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (etkinlikler[index].id != null) {
                                      DatabaseHelper().deleteEtkinlik(
                                          etkinlikler[index].id!);
                                      _loadEtkinlikler();
                                    } else {
                                      print('Etkinlik ID bulunamadı.');
                                    }
                                  }, // İlgili kapanış parantezi burada eklenmiştir
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
              },
            ),
    );
  }
}
