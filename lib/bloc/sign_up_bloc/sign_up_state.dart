abstract class SignUpState {}

class SignUpInitState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {
  final String message;
  SignUpSuccessState({required this.message});
  
}

class SignUpErrorState extends SignUpState {
  final String error;
  SignUpErrorState({required this.error});
}