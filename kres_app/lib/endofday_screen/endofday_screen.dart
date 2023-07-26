import 'package:flutter/material.dart';

import 'data/endofday_data.dart';

import 'widgets/endofday_widgets.dart';

class EndOfDay extends StatelessWidget {
  const EndOfDay({Key? key}) : super(key: key);
  static String routeName = 'AssignmentScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gün Sonu'),
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
                                  width: 350,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 43, 117, 88)
                                        .withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      assignment[index].subjectName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight
                                                  .bold // Yeni font boyutu değeri
                                              ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                // Text(
                                //   assignment[index].topicName,
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .titleMedium!
                                //       .copyWith(
                                //         color: Colors.black87,
                                //         fontWeight: FontWeight.w900,
                                //       ),
                                // ),
                                // SizedBox(
                                //   height: 20,
                                // ),
                                // AssignmentDetailRow(
                                //   title: 'Kahvaltı',
                                //   statusValue: assignment[index].assignDate,
                                // ),
                                // SizedBox(
                                //   height: 20,
                                // ),
                                // AssignmentDetailRow(
                                //   title: 'Öğle yemeği',
                                //   statusValue: assignment[index].lastDate,
                                // ),
                                // SizedBox(
                                //   height: 20,
                                // ),
                                // AssignmentDetailRow(
                                //   title: 'Uyku',
                                //   statusValue: assignment[index].status,
                                // ),
                                // SizedBox(
                                //   height: 20,
                                // ),
                                //use condition here to display button
                                // if (assignment[index].status == 'Orta')
                                //   //then show button
                                //   AssignmentButton(
                                //     onPress: () {
                                //       //submit here
                                //     },
                                //     title: 'To be Submitted',
                                //   ),
                                // if (assignment[index].status == 'Orta')
                                //   AssignmentDetailRow(
                                //     title: 'Kahvaltı',
                                //     statusValue: assignment[index].assignDate,
                                //     statusIcon: Icon(
                                //         Icons.alarm), // Burada bir ikon ekledik
                                //   ),
                                SizedBox(
                                  height: 20,
                                ),
                                if (assignment[index].assignDate == 'İyi')
                                  AssignmentDetailRow(
                                    title: 'Kahvaltı',
                                    statusValue: assignment[index].assignDate,
                                    imageAsset: 'assets/iyi.png',
                                  ),
                                if (assignment[index].assignDate == 'Orta')
                                  AssignmentDetailRow(
                                    title: 'Kahvaltı',
                                    statusValue: assignment[index].assignDate,
                                    imageAsset: 'assets/orta.png',
                                  ),
                                if (assignment[index].assignDate == 'Kötü')
                                  AssignmentDetailRow(
                                    title: 'Kahvaltı',
                                    statusValue: assignment[index].assignDate,
                                    imageAsset: 'assets/kötü.png',
                                  ),
                                SizedBox(
                                  height: 20,
                                ),
                                if (assignment[index].lastDate == 'İyi')
                                  AssignmentDetailRow(
                                    title: 'Öğlen Yemeği',
                                    statusValue: assignment[index].lastDate,
                                    imageAsset:
                                        'assets/iyi.png', // Resmin dosya adını buraya ekleyin
                                  ),
                                if (assignment[index].lastDate == 'Orta')
                                  AssignmentDetailRow(
                                    title: 'Öğlen Yemeği',
                                    statusValue: assignment[index].lastDate,
                                    imageAsset:
                                        'assets/orta.png', // Resmin dosya adını buraya ekleyin
                                  ),
                                if (assignment[index].lastDate == 'Kötü')
                                  AssignmentDetailRow(
                                    title: 'Öğlen Yemeği',
                                    statusValue: assignment[index].lastDate,
                                    imageAsset:
                                        'assets/kötü.png', // Resmin dosya adını buraya ekleyin
                                  ),
                                SizedBox(
                                  height: 20,
                                ),
                                if (assignment[index].status == 'İyi')
                                  AssignmentDetailRow(
                                    title: 'Uyku',
                                    statusValue: assignment[index].status,
                                    imageAsset:
                                        'assets/iyi.png', // Resmin dosya adını buraya ekleyin
                                  ),
                                if (assignment[index].status == 'Orta')
                                  AssignmentDetailRow(
                                    title: 'Uyku',
                                    statusValue: assignment[index].status,
                                    imageAsset:
                                        'assets/orta.png', // Resmin dosya adını buraya ekleyin
                                  ),
                                if (assignment[index].status == 'Kötü')
                                  AssignmentDetailRow(
                                    title: 'Uyku',
                                    statusValue: assignment[index].status,
                                    imageAsset:
                                        'assets/kötü.png', // Resmin dosya adını buraya ekleyin
                                  ),
                                SizedBox(
                                  height: 20,
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
