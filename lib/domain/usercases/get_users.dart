
import '../../data/repositories/user_repository.dart';
import '../entities/user.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<List<User>> call(int page) async {
    return await repository.getUsers(page);
  }
}
