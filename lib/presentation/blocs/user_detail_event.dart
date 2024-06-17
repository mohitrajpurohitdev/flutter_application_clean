part of 'user_detail_bloc.dart';

abstract class UserDetailEvent extends Equatable {
  const UserDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadUserDetail extends UserDetailEvent {
  final int id;

  LoadUserDetail(this.id);

  @override
  List<Object> get props => [id];
}
