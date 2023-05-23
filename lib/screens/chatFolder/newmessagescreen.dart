import 'package:flutter/material.dart';

class NewMessageScreen extends StatefulWidget {
  const NewMessageScreen({super.key});

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 113, 113, 109),
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        title: const Text("New Message"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.close_rounded,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              //padding: const EdgeInsets.only(top: 10),
              width: 333,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.black26)),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(fontSize: 12),
                  suffixIcon: Icon(
                    Icons.search_outlined,
                    size: 19,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 20, top: 5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
