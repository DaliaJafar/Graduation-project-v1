import 'package:flutter/material.dart';

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}


var secondaryColor = Color.fromARGB(255, 166, 76, 182);
var primaryColor = Color.fromARGB(255, 190, 72, 226);
