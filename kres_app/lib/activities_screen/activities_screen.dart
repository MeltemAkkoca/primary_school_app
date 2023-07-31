import 'package:flutter/material.dart';
import '../models/etkinlikler.dart';
import 'widgets/activities_widgets.dart';
import '../models/user_authentication/database_helper.dart';

class AssignmentScreen extends StatelessWidget {
  final String studentClassName;

  const AssignmentScreen({Key? key, required this.studentClassName})
      : super(key: key);

  static String routeName = 'AssignmentScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Etkinlikler'),
        backgroundColor: Color.fromARGB(255, 43, 117, 88),
      ),
      body: FutureBuilder<List<Etkinlikler>>(
        future: DatabaseHelper().loadEtkinlikler(studentClassName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Etkinlikler> etkinliklerList = snapshot.data!;
            return Column(
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
                      itemCount: etkinliklerList.length,
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
                                          etkinliklerList[index].eventName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      etkinliklerList[index].description,
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
                                      statusValue:
                                          etkinliklerList[index].startTime,
                                    ),
                                    SizedBox(height: 10),
                                    AssignmentDetailRow(
                                      title: 'Bitiş zamanı',
                                      statusValue:
                                          etkinliklerList[index].endTime,
                                    ),
                                    SizedBox(height: 10),
                                    AssignmentDetailRow(
                                      title: 'Durum',
                                      statusValue:
                                          etkinliklerList[index].eventStatus,
                                    ),
                                    SizedBox(height: 10),
                                    if (etkinliklerList[index].eventStatus ==
                                        'Pending')
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
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
