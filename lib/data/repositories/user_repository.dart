import 'package:flutter_application_clean/domain/entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers(int page);
  Future<User> getUserDetail(int id);
}
