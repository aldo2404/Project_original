import 'package:flutter/material.dart';
import 'package:fx_project/layout/background_screen.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackGroundImg().backGroundColor(),
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        centerTitle: true,
        title: const Text("Chat"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
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
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 1, 21, 88),
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 38,
        ),
      ),
    );
  }
}
