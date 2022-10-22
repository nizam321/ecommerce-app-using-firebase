import 'package:flutter/material.dart';

Widget customTextField(String hintext, keyBoardType, controller) {
  return TextField(
    keyboardType: keyBoardType,
    controller: controller,
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(),
      labelText: hintext,
    ),
  );
}
