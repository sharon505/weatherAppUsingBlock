part of 'post_bloc.dart';



sealed class PostState {}

class PostInitialState extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final List<ModelClass> posts;
  PostLoadedState(this.posts);
}

class PostErrorState extends PostState {
  final String message;
  PostErrorState(this.message);
}
