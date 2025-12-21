abstract class VerifyEvent {}

class SubmitVerifyOtp extends VerifyEvent {
  final String phone;
  final String otp;
  final String password;
  final String password_confirmation;

  SubmitVerifyOtp({
    required this.phone,
    required this.otp,
    required this.password,
    required this.password_confirmation,
  });
}