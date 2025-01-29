import 'dart:convert';

import 'package:ai/Sample1/apiCalling/ModelClass.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart'as http;

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitialState());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is FetchPostsEvent) {
      yield PostLoadingState(); // Yield loading state before fetching data

      try {
        final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

        if (response.statusCode == 200) {
          final data = json.decode(response.body) as List<dynamic>;
          List<ModelClass> posts = data.map((i) => ModelClass.fromJson(i)).toList();
          yield PostLoadedState(posts); // Yield loaded state with fetched data
        } else {
          yield PostErrorState('Failed to load data');
        }
      } catch (e) {
        yield PostErrorState('Error: $e'); // Yield error state in case of an exception
      }
    }
  }
}