import 'package:flutter/material.dart';

class DuplicateCameraPage extends StatefulWidget {
  const DuplicateCameraPage({super.key});

  @override
  State<DuplicateCameraPage> createState() => _DuplicateCameraPageState();
}

class _DuplicateCameraPageState extends State<DuplicateCameraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        centerTitle: true,
        title: const Text("doop camera page"),
      ),
      body: const Center(
        child: Text(
          'Camera page UI design progress ongoing',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
