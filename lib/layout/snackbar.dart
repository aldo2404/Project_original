import 'package:flutter/material.dart';

class ShowSnackBar {
  snackBarMessage(BuildContext context, String contentText) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
          padding: const EdgeInsets.all(16),
          height: 90,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 238, 7, 65),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Center(
            child: Text(
              contentText,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          )),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(seconds: 1),
    ));
  }
}
