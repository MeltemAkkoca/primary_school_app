import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SendedForm extends StatelessWidget {
  String name, email, phone;
  SendedForm({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('İsim: $name'),
            Text('Telefon numarası: $email'),
            Text('Not: $phone'),
          ],
        ),
      ),
    );
  }
}
