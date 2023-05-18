// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyDropDown {
  List<dynamic> listData;
  MyDropDown({
    required this.listData,
  });
  void bottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return MyDropDownList(
              listData: listData,
            );
          });
        });
  }
}

class MyDropDownList extends StatefulWidget {
  String? printData;
  String? titleText;
  List<dynamic> listData;
  bool isSearchVisibility;
  final TextField? searchField;
  Widget? Function(BuildContext, int)? itemBuilder;
  TextEditingController? controller;

  MyDropDownList(
      {this.isSearchVisibility = true,
      required this.listData,
      this.printData,
      this.searchField,
      this.titleText,
      this.itemBuilder,
      this.controller,
      super.key});

  @override
  State<MyDropDownList> createState() => _MyDropDownListState();
}

class _MyDropDownListState extends State<MyDropDownList> {
  final TextEditingController searchEditingController = TextEditingController();
  List<dynamic> myList = [];

  @override
  void initState() {
    super.initState();
    initState();
    myList = widget.listData;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
            showCursor: false,
            controller: widget.controller,
            decoration: const InputDecoration(
                hintText: "selectiondata",
                suffixIcon: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: 24,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)))),
            onTap: () async {
              await showModalBottomSheet(
                  isScrollControlled: false,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15))),
                  context: context,
                  builder: (context) {
                    return DraggableScrollableSheet(
                        initialChildSize: 0.7,
                        minChildSize: 0.13,
                        maxChildSize: 0.9,
                        expand: false,
                        builder: (BuildContext context,
                            ScrollController scrollController) {
                          return Column(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: ListTile(
                                    leading: IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(
                                            Icons.arrow_back_ios_new_sharp)),
                                    title: Text(
                                      widget.titleText!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: TextField(
                                  controller: searchEditingController,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.black12,
                                    contentPadding: EdgeInsets.only(
                                        left: 0,
                                        top: 8.0,
                                        bottom: 8.0,
                                        right: 15.0),
                                    hintText: "Search",
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    final results = widget.listData
                                        .where((element) => element.name
                                            .toLowerCase()
                                            .contains(value.toLowerCase()))
                                        .toList();
                                    if (value.isEmpty) {
                                      myList = widget.listData;
                                    } else {
                                      myList = results;
                                    }
                                    setState(() {});
                                  },
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: myList.length,
                                  itemBuilder: widget.itemBuilder!,
                                  // (context, index) {
                                  //   return Container(
                                  //     decoration: const BoxDecoration(
                                  //         border: Border(
                                  //             bottom: BorderSide(
                                  //                 color: Colors.black26))),
                                  //     child: ListTile(
                                  //       title: Text(myList.toString()),
                                  //       subtitle: Text(myList.toString()),
                                  //       onTap: () {
                                  //         setState(() {
                                  //           widget.printData = myList.toString();
                                  //         });
                                  //         Navigator.of(context).pop();
                                  //       },
                                  //     ),
                                  //   );
                                  // },
                                ),
                              ),
                            ],
                          );
                        });
                  });
            }));
  }

  void onClearTap() {
    searchEditingController.clear();
  }

  // void _setSearchWidgetListener() {
  //   TextFormField? _searchField =
  //       (widget.listData.searchWidget as TextFormField?);
  //   _searchField?.controller?.addListener(() {
  //     _buildSearchList(_searchField.controller?.text ?? '');
  //   });
  // }
}

// // ignore: must_be_immutable
// class BodyOfBottomSheet extends StatefulWidget {
//   List<dynamic>? listData;
//   String? printData;
//   BodyOfBottomSheet({this.listData, this.printData, super.key});

//   @override
//   State<BodyOfBottomSheet> createState() => _BodyOfBottomSheetState();
// }

// class _BodyOfBottomSheetState extends State<BodyOfBottomSheet> {
//   List<dynamic>? listData;
//   String? printData;
//   final TextEditingController searchEditingController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return DraggableScrollableSheet(
//         builder: (BuildContext context, ScrollController scrollController) {
//       return FutureBuilder(
//           //future: ,
//           builder: (context, snapshot) {
//         return Column(
//           children: [
//             Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: ListTile(
//                   leading: IconButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       icon: const Icon(Icons.arrow_back_ios_new_sharp)),
//                   title: const Text(
//                     "Data",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 )),
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: TextField(
//                 controller: searchEditingController,
//                 decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.black12,
//                     contentPadding: const EdgeInsets.only(
//                         left: 0, top: 10.0, bottom: 10.0, right: 15.0),
//                     hintText: "Search",
//                     border: const OutlineInputBorder(
//                       borderSide: BorderSide(
//                         width: 0,
//                         style: BorderStyle.none,
//                       ),
//                       borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                     ),
//                     prefixIcon: const IconButton(
//                       icon: Icon(Icons.search),
//                       onPressed: null,
//                     ),
//                     suffixIcon: GestureDetector(
//                       onTap: onClearTap,
//                       child: const Icon(Icons.close),
//                     )),
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                   itemCount: listData!.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       decoration: const BoxDecoration(
//                           border: Border(
//                               bottom: BorderSide(color: Colors.black26))),
//                       child: ListTile(
//                         title: Text(listData![index]['name'].toString()),
//                         subtitle: Text(listData![index]['address'].toString()),
//                         onTap: () {
//                           setState(() {
//                             printData = listData![index]['name'].toString();
//                           });
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                     );
//                   }),
//             ),
//           ],
//         );
//       });
//     });
//   }

//   void onClearTap() {
//     searchEditingController.clear();
//   }
// }
