import 'package:flutter/material.dart';

Padding ItemDetailScreenField(String aboutField, String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          aboutField.toString(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          text.toString(),
          style: TextStyle(fontSize: 20),
        ),
      ],
    ),
  );
}
