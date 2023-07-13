import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

AwesomeDialog awesome_dialog(BuildContext context, Text text) {
  return AwesomeDialog(context: context, title: "Error", body: text);
}
