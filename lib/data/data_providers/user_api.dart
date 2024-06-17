import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserApi {
  final String baseUrl = 'https://reqres.in/api';

  Future<List<UserModel>> fetchUsers(int page) async {
    final response = await http.get(Uri.parse('$baseUrl/users?page=$page'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List users = data['data'];
      return users.map((user) => UserModel.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<UserModel> fetchUserDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return UserModel.fromJson(data['data']);
    } else {
      throw Exception('Failed to load user detail');
    }
  }
}
