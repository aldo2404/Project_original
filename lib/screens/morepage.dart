import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () =>
              Navigator.of(context).maybePop((route) => route.isFirst),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        centerTitle: true,
        title: const Text("More"),
      ),
      body: Column(
        children: const [
          ListTile(
            title: Text(
              'Photo Bank',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 1, 46, 83)),
            ),
            leading: Icon(
              Icons.insert_photo_outlined,
              color: Color.fromARGB(255, 1, 46, 83),
            ),
          ),
          ListTile(
            title: Text('Timesheet',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 46, 83))),
            leading: Icon(Icons.pending_actions_sharp,
                color: Color.fromARGB(255, 1, 46, 83)),
          ),
          ListTile(
            title: Text('Profile',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 46, 83))),
            leading: Icon(Icons.perm_contact_calendar_rounded,
                color: Color.fromARGB(255, 1, 46, 83)),
          ),
          ListTile(
            title: Text('Help Center',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 46, 83))),
            leading: Icon(Icons.headset_mic_rounded,
                color: Color.fromARGB(255, 1, 46, 83)),
          ),
          ListTile(
            title: Text(
              'Settings',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 1, 46, 83)),
            ),
            leading:
                Icon(Icons.settings, color: Color.fromARGB(255, 1, 46, 83)),
          ),
        ],
      ),
    );
  }
}
