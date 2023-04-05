import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:new_mee/social-post/all-posts/all-posts-model.dart';

class SinglePostMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static List<Post> Postslist;

  Future<Post> getPostDetails(String id) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/post/${id}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data[0]);
      //print(Post.fromMappp(data[0]));
      return Post.fromMaq(data);
    } else {
      throw Exception("Failed to load infos");
    }
  }
}