import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_project/layout/cardlist.dart';
import 'package:fx_project/models/alljobsresponsemodel.dart';
import 'package:fx_project/screens/alljobs_screen/bloc/bloc_alljobs.dart';
import 'package:fx_project/screens/alljobs_screen/bloc/event_alljobs.dart';
import 'package:fx_project/screens/alljobs_screen/bloc/state_alljobs.dart';
import 'package:fx_project/screens/alljobs_screen/repository_alljobs.dart';
import 'package:fx_project/screens/alljobs_screen/services.dart';
import 'package:fx_project/screens/dashboardpage.dart';

// import 'package:pagination_app/cubit/posts_cubit.dart';
// import 'package:pagination_app/data/models/post.dart';

class AllJobsScreen2 extends StatelessWidget {
  // final PaginationRepository repository;
  final String emergency;
  // const EmergencyScreen({Key? key, required this.repository}) : super(key: key);
  const AllJobsScreen2({Key? key, required this.emergency}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<PaginationRepository>(
      create: (context) => PaginationRepository(AllJobsService()),
      child: BlocProvider<PostBloc>(
        create: (context) => PostBloc(context.read<PaginationRepository>())
          ..add(FetchPostsEvent()),
        child: AllJobsScreenPage(eme: emergency),
      ),
    );
  }
}

//final  PaginationRepository repository;

//  const EmergencyScreen({Key? key, this.repository}) : super(key: key);
class AllJobsScreenPage extends StatefulWidget {
  final String eme;
  const AllJobsScreenPage({super.key, required this.eme});

  @override
  State<AllJobsScreenPage> createState() => _AllJobsScreenPageState();
}

class _AllJobsScreenPageState extends State<AllJobsScreenPage> {
  int page = 1;
  late PaginationRepository repo;
  @override
  Widget build(BuildContext context) {
    var emecount = widget.eme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${emecount} All Jobs',
        ),
        //   title: Text("Posts"),
        leading: (Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const DashboardPage())),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        )),
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 4, 31, 68),
        //title: const Text('AppBar Demo'),
        actions: const <Widget>[],
      ),
      body: BlocBuilder<PostBloc, PostsState>(builder: (context, state) {
        if (state is PostLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PostSuccessState) {
          List<dynamic> posts = state.posts;
          print('screenposts$posts');
          return RefreshIndicator(
            onRefresh: refresh,
            child: Column(
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
                      controller: context.read<PostBloc>().scrollController,
                      itemCount: context.read<PostBloc>().isLoadingMore
                          ? posts.length + 1
                          : posts.length,
                      itemBuilder: ((context, index) {
                        if (index >= posts.length) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          Result post = posts[index];
                          print('eme pos${post.id}');
                          return cardListContainer(
                              post.property.toString(),
                              post.serviceType,
                              post.id,
                              post.stage.name,
                              post.issueType,
                              post.priority.toString(),
                              post.status,
                              post.category);
                        }
                      })),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: context.read<PostBloc>().isLoadingMore
                ? const CircularProgressIndicator()
                : const Text('No data'),
          );
        }
      }),
    );
  }

  Future refresh() async {
    List<Result>? posts = await repo.fetchPosts(page);
    setState(() {
      posts = posts;
    });
  }
}
