import 'dart:convert';

import 'package:flutter_json_serializable/models/post.dart';
import 'package:http/http.dart' as http;

const BASE_URL = 'https://jsonplaceholder.typicode.com/';
const POSTS_URL = BASE_URL + 'posts';

class PostAPIServices {
  static Future<dynamic> getPosts() async {
    final response = await http.get(POSTS_URL);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final posts = List<Post>();
      final data = jsonDecode(response.body);
      for (Map i in data) {
        posts.add(Post.fromJson(i));
      }
      return posts;
    }

    return 'Failed to get posts!';
  }
}
