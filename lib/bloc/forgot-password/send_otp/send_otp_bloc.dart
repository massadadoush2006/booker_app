import 'package:booker/bloc/forgot-password/send_otp/send_otp_event.dart';
import 'package:booker/bloc/forgot-password/send_otp/send_otp_state.dart';
import 'package:booker/service/forget_password_auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendOtpBloc extends Bloc<SendOtpEvent, SendOtpState> {
  final ForgetPasswordService service;

  SendOtpBloc(this.service) : super(SendOtpInitial()) {
    on<SendOtpPressed>((event, emit) async {
      emit(SendOtpLoading());

      final result = await service.sendOtp(phone: event.phone);

      if (result["success"] == true) {
        emit(SendOtpSuccess(result["message"]));
      } else {
        emit(SendOtpError(result["message"]));
      }
    });
  }
}