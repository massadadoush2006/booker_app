import 'package:booker/bloc/forgot-password/reset_password/reset_password_event.dart';
import 'package:booker/bloc/forgot-password/reset_password/reset_password_state.dart';
import 'package:booker/service/forget_password_auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ForgetPasswordService service;

  ResetPasswordBloc(this.service) : super(ResetPasswordInitial()) {
    on<ResetPasswordPressed>((event, emit) async {
      emit(ResetPasswordLoading());

      final result = await service.resetPassword(
        phone: event.phone,
        password: event.password,
        passwordConfirmation: event.confirm,
      );

      if (result["success"] == true) {
        emit(ResetPasswordSuccess(result["message"]));
      } else {
        emit(ResetPasswordError(result["message"]));
      }
    });
  }
}