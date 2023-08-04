import 'package:flutter/material.dart';
import 'package:meditation_app/models/user_authentication/database_helper.dart';

import '../models/end_of_day.dart';
import 'data/endofday_data.dart';

import 'widgets/endofday_widgets.dart';

class EndOfDay extends StatelessWidget {
  final String studentId;

  const EndOfDay({Key? key, required this.studentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gün Sonu'),
        backgroundColor: Color.fromARGB(255, 43, 117, 88),
      ),
      body: FutureBuilder<EndofDay?>(
        future: DatabaseHelper().getEndofDay(studentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu!'));
          } else if (snapshot.hasData && snapshot.data != null) {
            final endofDay = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  AssignmentDetailRow(
                    title: 'Kahvaltı',
                    statusValue: endofDay.breakfast,
                    imageAsset: 'assets/${endofDay.breakfast}.png',
                  ),
                  AssignmentDetailRow(
                    title: 'Öğle Yemeği',
                    statusValue: endofDay.lunch,
                    imageAsset: 'assets/${endofDay.lunch}.png',
                  ),
                  AssignmentDetailRow(
                    title: 'Uyku',
                    statusValue: endofDay.sleep,
                    imageAsset: 'assets/${endofDay.sleep}.png',
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('Gün sonu bilgisi bulunamadı.'));
          }
        },
      ),
    );
  }
}
