part of 'post_bloc.dart';


sealed class PostEvent {}

class FetchPostsEvent extends PostEvent {}