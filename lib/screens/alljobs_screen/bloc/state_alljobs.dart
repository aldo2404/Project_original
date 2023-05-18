abstract class PostsState {
  final posts;
  PostsState(this.posts);
}

class InitState extends PostsState {
  InitState(super.posts);
}

class PostLoadingState extends PostsState {
  PostLoadingState(super.posts);
}

class PostSuccessState extends PostsState {
  PostSuccessState({required posts}) : super(posts);
}
