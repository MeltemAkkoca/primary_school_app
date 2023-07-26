import 'package:flutter/material.dart';

class AssignmentButton extends StatelessWidget {
  const AssignmentButton({
    Key? key,
    required this.title,
    required this.onPress,
    this.imageAsset, // Resmi eklemek için yeni bir özellik, imageAsset
  }) : super(key: key);

  final String title;
  final VoidCallback onPress;
  final String?
      imageAsset; // Yeni özelliği '?' ekledik, böylece bu özellik opsiyonel olacak

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 100,
        height: 50,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imageAsset != null) Image.asset(imageAsset!),
              if (imageAsset != null) SizedBox(width: 8),
              Text(title, style: Theme.of(context).textTheme.subtitle2),
            ],
          ),
        ),
      ),
    );
  }
}

class AssignmentDetailRow extends StatelessWidget {
  const AssignmentDetailRow({
    Key? key,
    required this.title,
    required this.statusValue,
    this.statusIcon,
    this.imageAsset, // Resmi eklemek için yeni bir özellik, imageAsset
  }) : super(key: key);

  final String title;
  final String statusValue;
  final Widget? statusIcon;
  final String?
      imageAsset; // Yeni özelliği '?' ekledik, böylece bu özellik opsiyonel olacak

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Color(0xFF313131),
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
        ),
        Row(
          children: [
            if (statusIcon != null) statusIcon!,
            if (statusIcon != null || imageAsset != null) SizedBox(width: 8),
            if (imageAsset != null) Image.asset(imageAsset!),
            if (imageAsset != null && statusIcon != null) SizedBox(width: 8),
            Text(
              statusValue,
              style:
                  Theme.of(context).textTheme.caption!.copyWith(fontSize: 20),
            ),
          ],
        ),
      ],
    );
  }
}
