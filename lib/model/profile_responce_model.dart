import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProfileResponceModel {
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final int userId;
  final String createdAt;
  final String updatedAt;
  final int id;
  ProfileResponceModel({
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  

  ProfileResponceModel copyWith({
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    int? userId,
    String? createdAt,
    String? updatedAt,
    int? id,
  }) {
    return ProfileResponceModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'dateOfBirth': dateOfBirth,
      'userId': userId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'id': id,
    };
  }

  factory ProfileResponceModel.fromMap(Map<String, dynamic> map) {
    return ProfileResponceModel(
      phoneNumber: map['phoneNumber'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      dateOfBirth: map['dateOfBirth'] as String,
      userId: map['userId'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileResponceModel.fromJson(String source) => ProfileResponceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProfileResponceModel(phoneNumber: $phoneNumber, firstName: $firstName, lastName: $lastName, dateOfBirth: $dateOfBirth, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt, id: $id)';
  }

  @override
  bool operator ==(covariant ProfileResponceModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.phoneNumber == phoneNumber &&
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.dateOfBirth == dateOfBirth &&
      other.userId == userId &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      other.id == id;
  }

  @override
  int get hashCode {
    return phoneNumber.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      dateOfBirth.hashCode ^
      userId.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      id.hashCode;
  }
}
