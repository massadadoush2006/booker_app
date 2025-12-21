import 'dart:io';

abstract class ProfileEvent {}

class SubmitProfileEvent extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String phoneNumber;
  final File personalImage;
  final File idImage;

  SubmitProfileEvent({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.personalImage,
    required this.idImage,
  });
}