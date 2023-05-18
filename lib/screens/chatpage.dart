import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        leading: IconButton(
          onPressed: () => Navigator.of(context)
              .pop(MaterialPageRoute(builder: (_) => const ChatPage())),
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
                const SizedBox(height: 20),
                Container(
                  //padding: const EdgeInsets.only(top: 10),
                  width: 333,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.black)),
                  child: const TextField(
                    decoration: InputDecoration(
                        hintText: 'Search',
                        suffixIcon: Icon(Icons.search_outlined),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
