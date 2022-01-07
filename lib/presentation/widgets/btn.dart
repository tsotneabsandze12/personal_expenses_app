import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color color;
  final double fontSize;
  final Color fontColor;
  final double radius;
  final callback;

  const Btn({
    Key? key,
    required this.text,
    required this.width,
    required this.height,
    required this.color,
    required this.fontSize,
    required this.fontColor,
    required this.radius,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          primary: color,
        ),
        onPressed: () {
          callback();
        },
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: fontColor,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
