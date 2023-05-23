import 'package:flutter/material.dart';

class BackGroundImg {
  images() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/background.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Align(
            alignment: const Alignment(0.0, -0.68),
            child: Image.asset(
              "assets/image/splashlogo.png",
              scale: 0.84,
            )),
      ],
    );
  }

  backGroundColor() {
    Color backgroundColor = const Color.fromARGB(255, 249, 7, 7);
    return backgroundColor;
  }
}
