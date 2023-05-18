import 'package:flutter/material.dart';

Widget environmentBox(String text) {
  bool isSelected = true;
  return GestureDetector(
    onTap: () {
      isSelected = !isSelected;
      //setState((){});
    },
    child: Container(
      //height: 80,
      //width: 200,
      //padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: isSelected
            ? Border.all(color: const Color.fromARGB(255, 230, 81, 0), width: 2)
            : null,
      ),
      child: Text(
        text,
        textAlign: TextAlign.end,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
