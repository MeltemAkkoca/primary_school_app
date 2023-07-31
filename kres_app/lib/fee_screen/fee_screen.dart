import 'package:flutter/material.dart';
import '../models/ödeme.dart';
import 'package:meditation_app/models/user_authentication/database_helper.dart';

class FeeScreen extends StatefulWidget {
  final String studentId;

  const FeeScreen({Key? key, required this.studentId}) : super(key: key);

  @override
  _FeeScreenState createState() => _FeeScreenState();
}

class _FeeScreenState extends State<FeeScreen> {
  late Future<List<Payment>> payments;

  @override
  void initState() {
    super.initState();
    payments = DatabaseHelper().getPaymentsbyStudent(widget.studentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amber,
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 43, 117, 88),
          title: Text('Ödeme')),
      body: FutureBuilder<List<Payment>>(
        future: payments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Column(
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: ListView.builder(
                    padding: EdgeInsets.all(20),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Payment payment = snapshot.data![index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                  color: Color.fromARGB(255, 246, 246, 246),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromARGB(77, 100, 96, 96),
                                        blurRadius: 3.0)
                                  ]),
                              child: Column(
                                children: [
                                  FeeDetailRow(
                                      title: 'Makbuz No',
                                      statusValue: payment.decontNo),
                                  SizedBox(
                                    height: 20,
                                    child: Divider(
                                      thickness: 1.0,
                                    ),
                                  ),
                                  FeeDetailRow(
                                      title: 'Ay',
                                      statusValue: payment.payMonth),
                                  SizedBox(
                                    height: 20,
                                    child: Divider(
                                      thickness: 1.0,
                                    ),
                                  ),
                                  FeeDetailRow(
                                      title: 'Ödeme tarihi',
                                      statusValue: payment.payDate),
                                  SizedBox(
                                    height: 20,
                                    child: Divider(
                                      thickness: 1.0,
                                    ),
                                  ),
                                  FeeDetailRow(
                                      title: 'Ödeme durumu',
                                      statusValue: payment.payStatus),
                                  SizedBox(
                                    height: 20,
                                    child: Divider(
                                      thickness: 1.0,
                                    ),
                                  ),
                                  FeeDetailRow(
                                      title: 'Toplam Tutar',
                                      statusValue: payment.totalPay),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ))
              ],
            );
          }
        },
      ),
    );
  }
}

class FeeDetailRow extends StatelessWidget {
  const FeeDetailRow({Key? key, required this.title, required this.statusValue})
      : super(key: key);
  final String title;
  final String statusValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 14.0,
              color: Color.fromARGB(77, 0, 0, 0),
              fontWeight: FontWeight.bold),
        ),
        Text(
          statusValue,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 14.0,
              color: Color.fromARGB(77, 0, 0, 0),
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
