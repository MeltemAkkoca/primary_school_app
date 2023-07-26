import 'package:flutter/material.dart';

import 'data/fee_data.dart';

class FeeScreen extends StatelessWidget {
  const FeeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amber,
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 43, 117, 88),
          title: Text('Ödeme')),
      body: Column(
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: fee.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
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
                                statusValue: fee[index].receiptNo),
                            SizedBox(
                              height: 20,
                              child: Divider(
                                thickness: 1.0,
                              ),
                            ),
                            FeeDetailRow(
                                title: 'Ay', statusValue: fee[index].month),
                            SizedBox(
                              height: 20,
                              child: Divider(
                                thickness: 1.0,
                              ),
                            ),
                            FeeDetailRow(
                                title: 'Ödeme tarihi',
                                statusValue: fee[index].date),
                            SizedBox(
                              height: 20,
                              child: Divider(
                                thickness: 1.0,
                              ),
                            ),
                            FeeDetailRow(
                                title: 'Ödeme durumu',
                                statusValue: fee[index].paymentStatus),
                            SizedBox(
                              height: 20,
                              child: Divider(
                                thickness: 1.0,
                              ),
                            ),
                            FeeDetailRow(
                                title: 'Toplam Tutar',
                                statusValue: fee[index].totalAmount),
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
        )
      ],
    );
  }
}
