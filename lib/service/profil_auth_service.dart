import 'dart:io';
import 'package:booker/model/profile_responce_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:8000/api",
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );
  Future<ProfileResponceModel> submitProfile({
  required String firstName,
  required String lastName,
  required String dateOfBirth,
  required File personalImage,
  required File idImage,
}) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("auth_token");

    final formData = FormData.fromMap({
      'first_name': firstName,
      'last_name': lastName,
      'date_of_birth': dateOfBirth,
      'personal_image': await MultipartFile.fromFile(
        personalImage.path,
        filename: personalImage.path.split('/').last,
      ),
      'id_image': await MultipartFile.fromFile(
        idImage.path,
        filename: idImage.path.split('/').last,
      ),
    });

    final response = await _dio.post(
      "/profile",
      data: formData,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "multipart/form-data",
        },
      ),
    );

    return ProfileResponceModel.fromJson(response.data);
  } on DioException catch (e) {
    throw Exception(e.response?.data["error"] ?? "Profile submission failed");
  } catch (e) {
    throw Exception("Unexpected error occurred: $e");
  }
}

}