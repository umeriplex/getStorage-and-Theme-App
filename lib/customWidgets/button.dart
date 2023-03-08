import 'package:flutter/material.dart';
import 'package:local_storage_app_theme/views/theme/theme.dart';


class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const MyButton({
    Key? key,
    required this.onTap,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryClr
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      )
    );
  }
}
