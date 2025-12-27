import 'package:booker/bloc/forgot-password/verify_reset/verify_reset_event.dart';
import 'package:booker/bloc/forgot-password/verify_reset/verify_reset_state.dart';
import 'package:booker/service/forget_password_auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyResetBloc extends Bloc<VerifyResetEvent, VerifyResetState> {
  final ForgetPasswordService service;

  VerifyResetBloc(this.service) : super(VerifyResetInitial()) {
    on<VerifyResetCodePressed>((event, emit) async {
      emit(VerifyResetLoading());

      final result = await service.verifyOtp(
        phone: event.phone,
        otp: event.otp,
      );

      if (result["success"] == true) {
        emit(VerifyResetSuccess(result["message"]));
      } else {
        emit(VerifyResetError(result["message"]));
      }
    });
  }
}