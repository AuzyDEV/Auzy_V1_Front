import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:skeleton/user-profile/profile-model.dart';

class ProfilingMan {
  static String role;

  Future<User> GetCurrentUser() async {
    final responseuser = await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (responseuser.statusCode == 200) {
      final currentUser = jsonDecode(responseuser.body);
      String userId = currentUser["message"][0]['uid'];
      final responsedetails = await http.get(Uri.parse('http://127.0.0.1:3000/api/userinfos/${userId}'));
      if (responsedetails.statusCode == 200) {
        final currentUserDetails = jsonDecode(responsedetails.body);
        final currentUserDetail = currentUserDetails["message"][0];
        return User.fromMapp(currentUserDetail);
      } else {
        throw Exception("Failed to get infos");
      }
    } else {
      throw Exception("Failed to load infos");
    }
  }

  Future<String> GetCurrentUserRole() async {
    final responseuser = await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (responseuser.statusCode == 200) {
      final currentUser = jsonDecode(responseuser.body);
      String userId = currentUser["message"][0]['uid'];
      final responserole = await http.get(Uri.parse('http://127.0.0.1:3000/api/userole/${userId}'));
      if (responserole.statusCode == 200) {
        final currentUserRole = jsonDecode(responserole.body);
        role = currentUserRole["message"][0];
        return role;
      } else {
        throw Exception("Failed to get infos");
      }
    } else {
      throw Exception("Failed to load infos");
    }
  }

  Future<String> GetIDCurrentUser() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (response.statusCode == 200) {
      final currentUser = jsonDecode(response.body);
      String userId = currentUser["message"][0]['uid'];
      return userId;
    } else {
      throw Exception("Failed to load infos");
    }
  }

  Future<bool> DeleteCurrentUser() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (response.statusCode == 200) {
      final currentUser = jsonDecode(response.body);
      String userId = currentUser["message"][0]['uid'];
      final http.Response response1 = await http.delete(Uri.parse('http://127.0.0.1:3000/api/userinfo/${userId}'));
      if (response1.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception("Failed to load infos");
    }
  }

  Future<bool> UpdateprofilUser( String id, String email, String displayName, String photoURL) async {
    final response = await http.put(Uri.parse('http://127.0.0.1:3000/api/userinfo/${id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'displayName': displayName,
        'photoURL': photoURL,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> ChangePassword(String password) async {
    final response = await http.put(Uri.parse('http://127.0.0.1:3000/api/userpassword'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> BlockCurrentUser() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:3000/api/currentuser'));
    if (response.statusCode == 200) {
      final currentUser = jsonDecode(response.body);
      String userId = currentUser["message"][0]['uid'];
      final responsedit = await http.put(Uri.parse('http://127.0.0.1:3000/api/blocuser/${userId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
      if (responsedit.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception("Failed to load infos");
    }
  }
}
