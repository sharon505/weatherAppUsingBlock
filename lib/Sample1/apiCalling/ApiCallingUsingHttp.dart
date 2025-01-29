import 'dart:convert';

import 'package:ai/Sample1/apiCalling/ModelClass.dart';
import 'package:http/http.dart' as http;

// GetService getService = GetService();

Future<List<ModelClass>> fetchData() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body) as List<dynamic>;
    List<ModelClass> list = data.map((i) => ModelClass.fromJson(i)).toList();
    return list;
  } else {
    throw Exception('Failed to load');
  }
}

// class GetService{
// //<List<ModelClass>>
//   Future fetchData()async{
//     final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
//     print(response);
//   }
//
// }
