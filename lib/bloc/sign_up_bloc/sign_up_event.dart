import 'package:booker/model/usermodel.dart';

abstract class SignUpEvent {}

class SubmitSignUpEvent extends SignUpEvent {
  final Usermodel user;
  SubmitSignUpEvent({required this.user});
}