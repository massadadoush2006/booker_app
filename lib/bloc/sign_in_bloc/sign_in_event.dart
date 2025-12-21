import 'package:booker/model/usermodel.dart';

abstract class SignInEvent {}

class SubmitSignInEvent extends SignInEvent {
  final Usermodel user;
  SubmitSignInEvent({required this.user});
}

