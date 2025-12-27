abstract class VerifyResetEvent {}

class VerifyResetCodePressed extends VerifyResetEvent {
  final String phone;
  final String otp;

  VerifyResetCodePressed(this.phone, this.otp);
}