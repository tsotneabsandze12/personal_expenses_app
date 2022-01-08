import 'package:flutter/material.dart';

class CircularIconBtn extends StatelessWidget {
  final double? elevation;
  final Color? color;
  final double? padding;
  final Icon icon;
  final callback;

  const CircularIconBtn({
    Key? key,
    this.elevation,
    this.color,
    this.padding,
    required this.icon,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: elevation ?? 2,
      fillColor: color,
      child: icon,
      shape: const CircleBorder(),
      padding: padding == null ? EdgeInsets.zero : EdgeInsets.all(padding!),
      onPressed: () {
        callback();
      },
    );
  }
}
