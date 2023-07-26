import 'package:flutter/material.dart';

class AssignmentDetailRow extends StatelessWidget {
  const AssignmentDetailRow(
      {Key? key, required this.title, required this.statusValue})
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
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: Color(0xFF313131), fontWeight: FontWeight.w900),
        ),
        Text(
          statusValue,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}

class AssignmentButton extends StatelessWidget {
  const AssignmentButton({Key? key, required this.title, required this.onPress})
      : super(key: key);
  final String title;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 100,
        height: 7,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6789CA), Color(0xFF345FB4)],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(title, style: Theme.of(context).textTheme.subtitle2),
        ),
      ),
    );
  }
}
