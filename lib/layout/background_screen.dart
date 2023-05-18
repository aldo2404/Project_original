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
            )),
      ],
    );
  }
}
