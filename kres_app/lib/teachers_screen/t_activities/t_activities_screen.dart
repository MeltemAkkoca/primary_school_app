import 'package:flutter/material.dart';

import '../../activities_screen/widgets/activities_widgets.dart';
import 'saved_data/saved_data_screen.dart';

class TeacherAssignmentScreen extends StatefulWidget {
  const TeacherAssignmentScreen({Key? key}) : super(key: key);
  static String routeName = 'AssignmentScreen';

  @override
  _AssignmentScreenState createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<TeacherAssignmentScreen> {
  final List<AssignmentData> assignmentDataList = List.from(assignment);

  // void _saveData() {
  //   // You can add the logic here to save the data permanently or to a database
  //   // For this example, we will simply navigate to the next page with the first assignmentDataList element.
  //   if (assignmentDataList.isNotEmpty) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => SavedDataScreen(
  //           assignmentData: assignmentDataList[0],
  //         ),
  //       ),
  //     );
  //   }
  // }
  void _saveData() {
    if (assignmentDataList.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SavedDataScreen(
            assignmentDataList: assignmentDataList,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Etkinlikler'),
        backgroundColor: Color.fromARGB(255, 43, 117, 88),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF4F6F7),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: assignmentDataList.length,
                itemBuilder: (context, int index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                initialValue:
                                    assignmentDataList[index].subjectName,
                                onChanged: (value) {
                                  assignmentDataList[index].subjectName = value;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Subject Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                initialValue:
                                    assignmentDataList[index].topicName,
                                onChanged: (value) {
                                  assignmentDataList[index].topicName = value;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Topic Name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                initialValue:
                                    assignmentDataList[index].assignDate,
                                onChanged: (value) {
                                  assignmentDataList[index].assignDate = value;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Start Date',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                initialValue:
                                    assignmentDataList[index].lastDate,
                                onChanged: (value) {
                                  assignmentDataList[index].lastDate = value;
                                },
                                decoration: InputDecoration(
                                  labelText: 'End Date',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                initialValue: assignmentDataList[index].status,
                                onChanged: (value) {
                                  assignmentDataList[index].status = value;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Status',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  onPressed: _saveData,
                                  child: Text('Kaydet'),
                                ),
                              ),
                              SizedBox(height: 10),
                              if (assignmentDataList[index].status == 'Pending')
                                AssignmentButton(
                                  onPress: () {
                                    // Submit here
                                  },
                                  title: 'To be Submitted',
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AssignmentData {
  String subjectName;
  String topicName;
  String assignDate;
  String lastDate;
  String status;

  AssignmentData(
    this.subjectName,
    this.topicName,
    this.assignDate,
    this.lastDate,
    this.status,
  );
}

List<AssignmentData> assignment = [
  AssignmentData(
    'Oyun Hamuru Etkinliği',
    'Çocuklar oyun hamuruyla şekiller yaptı',
    '10 Temmuz 2023-10.00',
    '10 Temmuz 2023-10.30',
    'Tamamlandı',
  ),
  AssignmentData(
    'Masal Anlatımı Etkinliği',
    'Utku saat öncesi masal anlatımı yapıldı',
    '10 Temmuz 2023-10.30',
    '10 Temmuz 2023-11.00',
    'Tamamlandı',
  ),
  AssignmentData(
    'Boyama Etkinliği',
    'Renk temasına göre boyama yapılıyor',
    '10 Temmuz 2023-11.00',
    '10 Temmuz 2023-11.30',
    'Tamamlanıyor',
  ),
  AssignmentData(
    'Bil Bakalım Oyunu',
    'Bil bakalım oyunu oynatılacak',
    '10 Temmuz 2023-11.30',
    '10 Temmuz 2023-12.00',
    'Tamamlanacak',
  ),
];
