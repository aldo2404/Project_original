import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fx_project/layout/cardlist.dart';
import 'package:fx_project/models/alljobsresponsemodel.dart';
import 'package:fx_project/screens/environmentpage.dart';
import 'package:fx_project/services/alljobsservices.dart';

class AllJobsScreen extends StatefulWidget {
  final String alljobscount;
  const AllJobsScreen({super.key, required this.alljobscount});

  @override
  State<AllJobsScreen> createState() => _AllJobsScreenState();
}

class _AllJobsScreenState extends State<AllJobsScreen> {
  AllJobsResponesModel? allJob;
  bool hasMore = false;
  int page = 1;
  List<Result>? result = [];
  bool loading = false, allLoaded = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    //String url = '';
    _getData();
    //handleNext();
    _scrollController.addListener(_scrollListner);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  // _urlData() async {
  //   dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
  //   String baseurl = 'https://$baseurl1/v1/jobs/?filter=active';
  //   print(baseurl);
  //   return baseurl;
  // }

  Future<void> _getData() async {
    if (loading) return;
    loading = true;
    const limit = 20;
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    print(page);
    allJob = await (AllJobsServices(
      service: Dio(BaseOptions(
          baseUrl:
              'https://$baseurl1/v1/jobs/?filter=active?_limit=$limit&page=$page')),
    ).allJobsService());
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          page++;
          loading = false;
          if (allJob!.results!.length < limit) {
            hasMore = false;
          }
          result!.addAll(allJob!.results!);
        }));
    print("count: ${allJob?.count}");
    print("next: ${allJob!.next}");
    print("alljobs_$allJob");
  }

  Future<void> _scrollListner() async {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      await _getData();
    }
    // print("next: ${allJob!.next}");
    // print(allJob);
  }

  @override
  Widget build(BuildContext context) {
    var listcount = widget.alljobscount;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 48, 92),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text('$listcount All Jobs'),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder(
            future: getUsers(),
            builder: (context, snapshot) {
              if (result != null) {
                print(result!.length);
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Container(
                            alignment: Alignment.center,
                            width: 340,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.black)),
                            child: const Center(
                              child: Icon(
                                Icons.filter_list,
                                semanticLabel: 'Filter',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: result!.length,

                          //loading ? result!.length + 1 : result!.length,
                          itemBuilder: (context, index) {
                            if (index < result!.length) {
                              var property = result![index].property.toString();
                              var serviceType =
                                  result![index].serviceType.toString();
                              var id = result![index].id!.toInt();
                              var name = result![index].stage.name.toString();

                              var issueType =
                                  result![index].issueType.toString();
                              var priority = result![index].priority.toString();
                              var unit =
                                  allJob?.results![index].unit.toString();
                              var category = result![index].category.toString();
                              print(
                                  '${result!.length}_index_${result!.indexWhere((element) => false)}');

                              return cardListContainer(
                                  property,
                                  serviceType,
                                  id,
                                  name,
                                  issueType,
                                  priority,
                                  unit,
                                  category);
                            } else {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 32),
                                child: Center(
                                  child: hasMore
                                      ? const CircularProgressIndicator()
                                      : const Text('No more data to load '),
                                ),
                              );
                            }
                          }),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('result: ${snapshot.data}');
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  getUsers() {}

  Future refresh() async {
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    allJob = await (AllJobsServices(
      service: Dio(
          BaseOptions(baseUrl: 'https://${baseurl1}/v1/jobs/?filter=active')),
    ).allJobsService());
    setState(() {
      loading = false;
      hasMore = true;
      page = 1;
    });
    _getData();
  }
}
