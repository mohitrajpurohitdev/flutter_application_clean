
import 'package:flutter_application_clean/data/repositories/user_repository.dart';

import '../../domain/entities/user.dart';
import '../data_providers/user_api.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApi userApi;

  UserRepositoryImpl(this.userApi);

  @override
  Future<List<User>> getUsers(int page) async {
    final users = await userApi.fetchUsers(page);
    return users.map((userModel) => User(
      id: userModel.id,
      email: userModel.email,
      firstName: userModel.firstName,
      lastName: userModel.lastName,
      avatar: userModel.avatar,
    )).toList();
  }

  @override
  Future<User> getUserDetail(int id) async {
    final user = await userApi.fetchUserDetail(id);
    return User(
      id: user.id,
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      avatar: user.avatar,
    );
  }
}
