abstract class ResetPasswordEvent {}

class ResetPasswordPressed extends ResetPasswordEvent {
  final String phone;
  final String password;
  final String confirm;

  ResetPasswordPressed(this.phone, this.password, this.confirm);
}