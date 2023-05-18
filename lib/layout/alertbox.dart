import 'package:flutter/material.dart';

class ReuseAlertDialogBox {
  // String titletext = '';
  // String contenttext = '';
  Future alertDialog(
      BuildContext context, String titletext, String contenttext) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(titletext),
        content: Text(contenttext),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"))
        ],
      ),
    );
  }
}
