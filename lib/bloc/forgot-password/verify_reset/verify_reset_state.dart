abstract class VerifyResetState {}

class VerifyResetInitial extends VerifyResetState {}

class VerifyResetLoading extends VerifyResetState {}

class VerifyResetSuccess extends VerifyResetState {
  final String message;
  VerifyResetSuccess(this.message);
}

class VerifyResetError extends VerifyResetState {
  final String error;
  VerifyResetError(this.error);
}