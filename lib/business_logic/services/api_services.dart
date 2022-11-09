import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/comments.dart';

class ApiService {

   String getUrl = '';
   String nextgetUrl = '';
   Future<List<Comments>> getComments(int comments) async {
    getUrl= "https://jsonplaceholder.typicode.com/comments?_start=$comments&_limit=20";
    var response = await Dio().get(getUrl);
    if(response.statusCode == 200) {
      final Iterable json = response.data;
      return json.map((comment) => Comments.fromJson(comment)).toList();
    } else {
      throw Exception("Unable to perform request!");
    }
  }

  Future<void> postComment(Comments comment) async {
    String postUrl = 'https://cambium.co.il/test/testAssignComment';
    //check Data
    // String postUrl = 'https://jsonplaceholder.typicode.com/comments';
    try{
      var response = await Dio().post(postUrl, data: {
        'name': comment.name,
        'email': comment.email,
        'body': comment.body,
      });
        // ignore: avoid_print
        print('Response status: ${response.statusCode}');
        // ignore: avoid_print
        print('Response body: ${response.data}');
    }catch(e){
      // ignore: avoid_print
      print(e);
    }
  }
}

final apiProvider = Provider<ApiService>((ref) => ApiService());