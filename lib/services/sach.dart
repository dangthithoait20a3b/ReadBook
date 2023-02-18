import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/post.dart';


class sachAPI {
  static const String url = 'https://63ef856a271439b7fe707c69.mockapi.io/api/readbook/sach';
  static List<Post> parsePost(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<Post> posts = list.map((model) => Post.fromJson(model)).toList();
    return posts;
  }

  static Future<List<Post>> fetchPost({int page = 1}) async {
    http.Response response = await http.get(Uri.parse(url));
    String source = Utf8Decoder().convert(response.bodyBytes);
    if (response.statusCode == 200) {
      return compute(parsePost, source);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Can\'t get post');
    }
  }
}