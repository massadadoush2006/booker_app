class ProfileResponceModel {
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final int userId;
  final String createdAt;
  final String updatedAt;
  final int id;

  ProfileResponceModel({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  factory ProfileResponceModel.fromMap(Map<String, dynamic> map) {
    return ProfileResponceModel(
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      dateOfBirth: map['date_of_birth'] ?? '',
      userId: map['user_id'] ?? 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      id: map['id'] ?? 0,
    );
  }

  factory ProfileResponceModel.fromJson(Map<String, dynamic> json) =>
      ProfileResponceModel.fromMap(json);

      Map<String, dynamic> toJson() {
  return {
    "first_name": firstName,
    "last_name": lastName,
    "date_of_birth": dateOfBirth,
    "user_id": userId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "id": id,
  };
}
}