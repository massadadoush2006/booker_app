abstract class SendOtpState {}

class SendOtpInitial extends SendOtpState {}

class SendOtpLoading extends SendOtpState {}

class SendOtpSuccess extends SendOtpState {
  final String message;
  SendOtpSuccess(this.message);
}

class SendOtpError extends SendOtpState {
  final String error;
  SendOtpError(this.error);
}