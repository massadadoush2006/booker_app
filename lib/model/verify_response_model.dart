// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:booker/model/userinfo.dart';

class VerifyResponseModel {
   final bool success;
  final String message;
  final String token;
  final Userinfo user;
  
  VerifyResponseModel({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });
  



  VerifyResponseModel copyWith({
    bool? success,
    String? message,
    String? token,
    Userinfo? user,
  }) {
    return VerifyResponseModel(
      success: success ?? this.success,
      message: message ?? this.message,
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'message': message,
      'token': token,
      'user': user.toMap(),
    };
  }

  factory VerifyResponseModel.fromMap(Map<String, dynamic> map) {
    return VerifyResponseModel(
      success: map['success'] as bool,
      message: map['message'] as String,
      token: map['token'] as String,
      user: Userinfo.fromMap(map['user'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyResponseModel.fromJson(String source) => VerifyResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VerifyResponseModel(success: $success, message: $message, token: $token, user: $user)';
  }

  @override
  bool operator ==(covariant VerifyResponseModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.success == success &&
      other.message == message &&
      other.token == token &&
      other.user == user;
  }

  @override
  int get hashCode {
    return success.hashCode ^
      message.hashCode ^
      token.hashCode ^
      user.hashCode;
  }
}
