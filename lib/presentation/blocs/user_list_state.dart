part of 'user_list_bloc.dart';

abstract class UserListState extends Equatable {
  const UserListState();

  @override
  List<Object?> get props => [];
}

class UserListInitial extends UserListState {}

class UserListLoading extends UserListState {
  final List<User> users;
  final int page;

  const UserListLoading({required this.users, required this.page});

  @override
  List<Object?> get props => [users, page];
}

class UserListLoaded extends UserListState {
  final List<User> users;
  final int page;

  UserListLoaded({required this.users, required this.page});

  @override
  List<Object?> get props => [users, page];
}

class UserListError extends UserListState {
  final String message;
  final List<User> users;
  final int page;

  UserListError(
      {required this.message, required this.users, required this.page});

  @override
  List<Object?> get props => [message, users, page];
}
