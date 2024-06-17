import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_clean/domain/entities/user.dart';
import 'package:flutter_application_clean/domain/usercases/get_user_detail.dart';
part 'user_detail_event.dart';
part 'user_detail_state.dart';


class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final GetUserDetail getUserDetail;

  UserDetailBloc(this.getUserDetail) : super(UserDetailInitial()) {
    on<LoadUserDetail>((event, emit) async {
      emit(UserDetailLoading());
      try {
        final user = await  getUserDetail(event.id);
        emit(UserDetailLoaded(user: user));
      } catch (e) {
        emit(UserDetailError(message: e.toString()));
      }
    });
  }
}
