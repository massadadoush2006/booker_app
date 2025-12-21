abstract class SignInState {}

class SignInInitState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInSuccessState extends SignInState {
  final String message;
  SignInSuccessState({required this.message});
}

class SignInErrorState extends SignInState {
  final String error;
  SignInErrorState({required this.error});
}