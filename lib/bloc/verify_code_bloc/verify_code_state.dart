abstract class VerifyState {}

class VerifyInitState extends VerifyState {}

class VerifyLoadingState extends VerifyState {}

class VerifySuccessState extends VerifyState {
  final String message;
  VerifySuccessState({required this.message, required token});
}

class VerifyErrorState extends VerifyState {
  final String error;
  VerifyErrorState({required this.error});
}