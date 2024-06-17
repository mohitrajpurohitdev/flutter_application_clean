part of 'user_detail_bloc.dart';

abstract class UserDetailState extends Equatable {
  const UserDetailState();

  @override
  List<Object> get props => [];
}

class UserDetailInitial extends UserDetailState {}

class UserDetailLoading extends UserDetailState {}

class UserDetailLoaded extends UserDetailState {
  final User user;

  UserDetailLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class UserDetailError extends UserDetailState {
  final String message;

  UserDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
