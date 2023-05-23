import 'package:flutter/material.dart';

class ClickButton extends StatelessWidget {
  Widget child;
  Function()? onpressed;
  ClickButton({
    required this.child,
    this.onpressed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        width: 300,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange[900]),
              padding: const MaterialStatePropertyAll(
                  EdgeInsets.only(top: 10, bottom: 10))),
          onPressed: onpressed,
          child: child,
        ),
      ),
    );
  }
}
