import 'package:flutter/material.dart';

import 'data/activities_data.dart';
import 'widgets/activities_widgets.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({Key? key}) : super(key: key);
  static String routeName = 'AssignmentScreen';

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
                      topRight: Radius.circular(60))),
              child: ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: assignment.length,
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
                                      assignment[index].subjectName,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                Text(
                                  assignment[index].topicName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w900,
                                      ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                AssignmentDetailRow(
                                  title: 'Başlangıç zamanı',
                                  statusValue: assignment[index].assignDate,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                AssignmentDetailRow(
                                  title: 'Bitiş zamanı',
                                  statusValue: assignment[index].lastDate,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                AssignmentDetailRow(
                                  title: 'Durum',
                                  statusValue: assignment[index].status,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                //use condition here to display button
                                if (assignment[index].status == 'Pending')
                                  //then show button
                                  AssignmentButton(
                                    onPress: () {
                                      //submit here
                                    },
                                    title: 'To be Submitted',
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
