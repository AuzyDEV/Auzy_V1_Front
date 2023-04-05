import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../single-listing/single-listing-model.dart';

class AllListingsMan {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Doctor>> getAllDoctors() async {
    String collectionName = "doctors";
    final response = await http
        .get(Uri.parse('http://127.0.0.1:3000/api/DB/${collectionName}'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      //print(parsed["posts"]);
      final data = parsed["listCollections"];
      return data.map<Doctor>((json) => Doctor.fromMap(json)).toList();
    } else {
      throw Exception("Failed to get post's list");
    }
  }

  Future<List<Doctor>> getAllDoctorsWithSpeciality(String speciality) async {
    String collectionName = "doctors";
    final response = await http.get(Uri.parse(
        'http://127.0.0.1:3000/api/DataB/${collectionName}/${speciality}'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      //print(parsed["posts"]);
      final data = parsed["listCollections"];
      return data.map<Doctor>((json) => Doctor.fromMap(json)).toList();
    } else {
      throw Exception("Failed to get post's list");
    }
  }
}