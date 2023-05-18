import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class DropDownUiScreen extends StatefulWidget {
  List<dynamic> listData;
  Widget? Function(BuildContext, int) itemBuilder;
  String? titleText;

  DropDownUiScreen(
      {required this.listData,
      required this.itemBuilder,
      this.titleText,
      super.key});

  @override
  State<DropDownUiScreen> createState() => _DropDownUiScreenState();
}

class _DropDownUiScreenState extends State<DropDownUiScreen> {
  final TextEditingController searchEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.13,
        maxChildSize: 0.9,
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return FutureBuilder(
              //future: ,
              builder: (context, snapshot) {
            return Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListTile(
                      leading: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_sharp)),
                      title: Text(
                        widget.titleText!,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: searchEditingController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.black12,
                      contentPadding: EdgeInsets.only(
                          left: 10, top: 8.0, bottom: 8.0, right: 15.0),
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: widget.listData.length,
                    itemBuilder: widget.itemBuilder,
                  ),
                ),
              ],
            );
          });
        });
  }
}
