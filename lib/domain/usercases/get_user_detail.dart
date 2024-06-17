
import 'package:flutter_application_clean/data/repositories/user_repository.dart';

import '../entities/user.dart';

class GetUserDetail {
  final UserRepository repository;

  GetUserDetail(this.repository);

  Future<User> call(int id) async {
    return await repository.getUserDetail(id);
  }
}
