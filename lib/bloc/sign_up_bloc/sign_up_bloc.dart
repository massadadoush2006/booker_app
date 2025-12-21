import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booker/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:booker/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:booker/service/sign_up_auth_service.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpAuthService authService = SignUpAuthService();

  SignUpBloc() : super(SignUpInitState()) {
    on<SubmitSignUpEvent>((event, emit) async {
      emit(SignUpLoadingState());

      try {
        print("📤 Sending request...");

        final result = await authService.signUp(event.user);
        print("✅ Result in Bloc: $result");


       if (result["success"].toString() == "true") {
  emit(SignUpSuccessState(message: result["message"]));
} else {
  emit(SignUpErrorState(error: result["error"]));

        }
      } catch (e, stackTrace) {
        print("❌ Exception in SignUpBloc: $e");
        print("📌 StackTrace: $stackTrace");
        emit(SignUpErrorState(error: " Connection error : ${e.toString()}"));
      }
    });
  }
}