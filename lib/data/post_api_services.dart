import 'package:http/http.dart' as http;

const BASE_URL = 'https://jsonplaceholder.typicode.com/';
const POSTS_URL = BASE_URL + 'posts';

class PostAPIServices {
  static Future<dynamic> getPosts() async {
    final response = await http.get(POSTS_URL);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    // TODO: handle response

    return 'Failed to get posts!';
  }
}
