import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fx_project/layout/dashboardbox.dart';
import 'package:fx_project/models/dashboardresponsemodel.dart';
import 'package:fx_project/screens/alljobs_screen/alljobsscreen2.dart';
import 'package:fx_project/screens/createjobsscreen/createjobsscreen.dart';
import 'package:fx_project/screens/environmentpage.dart';
import 'package:fx_project/screens/loginpage.dart';
import 'package:fx_project/services/dashboardservices.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DashBoardResponesModel? bal;
  late String text1;
  late String text2;
  late String text3;
  late int t1;
  late int t2;
  late int t3;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    bal = await (DashBoardService(
      service: Dio(BaseOptions(baseUrl: 'https://$baseurl1')),
    ).dashBoardService());
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(
          () {},
        ));

    print("emergency: ${bal?.emergency}");
    print("jobs: ${bal?.all_jobs}");
  }

  @override
  Widget build(BuildContext context) {
    dynamic baseurl1 = EnvironmentPageState.getBaseurl() as dynamic;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 48, 92),
        leading: Image.asset('assets/image/splashlogo.png'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const LoginPage()));
              },
              icon: Icon(Icons.power_settings_new, color: Colors.orange[900]))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder(
            future: getUsers(),
            builder: (context, snapshot) {
              if (bal != null) {
                t1 = bal?.emergency as int;
                text1 = t1.toString();
                t2 = bal?.all_jobs as int;
                text2 = t2.toString();
                t3 = bal?.assigned_to_me as int;
                text3 = t3.toString();
                return Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 10, left: 10),
                      child: GridView(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 260,
                                  childAspectRatio: 2 / 3,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                  mainAxisExtent: 265),
                          children: [
                            dashBoardBox(Colors.amber[50], Icons.warning,
                                Colors.orange[900], text1, "Emergency", () {}),
                            dashBoardBox(
                                Colors.blue[50],
                                Icons.home_repair_service,
                                Colors.orange[600],
                                text2,
                                "All Jobs", () {
                              setState(() {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) =>
                                        AllJobsScreen2(emergency: text2)));
                              });
                            }),
                            dashBoardBox(Colors.pink[50], Icons.paste_sharp,
                                Colors.blue, text3, "Assigned To Me", () {}),
                          ]),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 40,
                          width: 333,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  maintainState: false,
                                  builder: (_) => const CreateJobsScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 1, 32, 58)),
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Create jobs',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
    bal = await (DashBoardService(
      service: Dio(BaseOptions(baseUrl: 'https://${baseurl1}')),
    ).dashBoardService());
    setState(() {
      bal = bal;
    });
  }
}
