part of 'user_list_bloc.dart';

abstract class UserListEvent extends Equatable {
  const UserListEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends UserListEvent {
  final int page;

  LoadUsers(this.page);

  @override
  List<Object> get props => [page];
}
