import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_project/models/alljobsresponsemodel.dart';
import 'package:fx_project/screens/alljobs_screen/bloc/event_alljobs.dart';
import 'package:fx_project/screens/alljobs_screen/bloc/state_alljobs.dart';
import 'package:fx_project/screens/alljobs_screen/repository_alljobs.dart';

class PostBloc extends Bloc<PostEvent, PostsState> {
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;
  int page = 1;
  PaginationRepository repo;
  PostBloc(this.repo) : super(InitState(null)) {
    scrollController.addListener(() {
      add(LoadMoreEvent());
    });
    on<FetchPostsEvent>(((event, emit) async {
      emit(PostLoadingState(null));
      List<Result>? posts = await repo.fetchPosts(page);
      print('blocoldposts$posts');
      emit(PostSuccessState(posts: posts));
    }));
    on<LoadMoreEvent>((event, emit) async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        isLoadingMore = true;
        page++;
        print(page);
        List<dynamic>? posts = await repo.fetchPosts(page);
        print('blocnewposts$posts');

        //emit(PostSuccessState(posts: posts1));
        emit(PostSuccessState(posts: [...state.posts, ...posts!]));
      }
    });
  }
}
