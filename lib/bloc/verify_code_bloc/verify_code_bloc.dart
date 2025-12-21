import 'package:booker/bloc/verify_code_bloc/verify_code_event.dart';
import 'package:booker/bloc/verify_code_bloc/verify_code_state.dart';
import 'package:booker/service/verify_code_auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  final AuthService authService;

  VerifyBloc(this.authService) : super(VerifyInitState()) {
    on<SubmitVerifyOtp>((event, emit) async {
      emit(VerifyLoadingState());
      try {
        final result = await authService.verifyOtp(
          phone: event.phone,
          otp: event.otp,
          password: event.password,
          passwordConfirmation: event.password_confirmation,
        );

        if (result["success"] == true) {
            
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("auth_token", result["token"]);

          emit(VerifySuccessState(
            message: result["message"],
            token: result["token"],
          ));
        } else {
          emit(VerifyErrorState(error: result["error"] ?? "Verification failed"));
        }
      } catch (e) {
        emit(VerifyErrorState(error: e.toString()));
      }
    });
  }
}