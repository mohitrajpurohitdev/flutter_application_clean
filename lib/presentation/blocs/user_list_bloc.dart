import 'package:equatable/equatable.dart';
import 'package:flutter_application_clean/domain/entities/user.dart';
import 'package:flutter_application_clean/domain/usercases/get_users.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final GetUsers getUsers;

  UserListBloc(this.getUsers) : super(UserListInitial()) {
    on<LoadUsers>(_onLoadUsers);
  }

  void _onLoadUsers(LoadUsers event, Emitter<UserListState> emit) async {
    if (state is UserListLoading) return;
    final currentState = state;
    var oldUsers = <User>[];
    var page = event.page;

    if (currentState is UserListLoaded) {
      oldUsers = currentState.users;
      page = event.page;
    }

    emit(UserListLoading(users: oldUsers, page: page));
    try {
      final newUsers = await getUsers(event.page);
      final users = oldUsers + newUsers;
      emit(UserListLoaded(users: users, page: page));
    } catch (e) {
      emit(UserListError(message: e.toString(), users: oldUsers, page: page));
    }
  }
}
