import 'package:flutter/cupertino.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double width;
  static late double height;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    width = _mediaQueryData.size.width;
    height = _mediaQueryData.size.height;
    blockSizeHorizontal = width / 100;
    blockSizeVertical = height / 100;
  }
}