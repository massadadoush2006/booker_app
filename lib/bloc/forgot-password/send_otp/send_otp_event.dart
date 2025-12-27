abstract class SendOtpEvent {}

class SendOtpPressed extends SendOtpEvent {
  final String phone;
  SendOtpPressed(this.phone);
}