import 'package:flutter/material.dart';

import '../t_activities_screen.dart';

class SavedDataScreen extends StatelessWidget {
  final List<AssignmentData> assignmentDataList;

  SavedDataScreen({required this.assignmentDataList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Data'),
        backgroundColor: Color.fromARGB(255, 43, 117, 88),
      ),
      body: ListView.builder(
        itemCount: assignmentDataList.length,
        itemBuilder: (context, index) {
          final AssignmentData assignmentData = assignmentDataList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Subject Name: ${assignmentData.subjectName}'),
                    Text('Topic Name: ${assignmentData.topicName}'),
                    Text('Start Date: ${assignmentData.assignDate}'),
                    Text('End Date: ${assignmentData.lastDate}'),
                    Text('Status: ${assignmentData.status}'),
                    Divider(), // Optional divider to separate each item
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
