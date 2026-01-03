import 'package:dio/dio.dart';
import 'package:booker/model/apartment_model.dart';

class ApartmentService {
  final Dio dio = Dio(BaseOptions(baseUrl: "http://10.0.2.2:8000/api"));

  Future<List<ApartmentModel>> fetchApartments() async {
  try {
    final response = await dio.get("/index");

    // إذا الرد يحتوي على data فارغة
    if (response.data["data"] is List && response.data["data"].isEmpty) {
      print("⚠️ No apartments available");
      return [];
    }

    final List data = response.data["data"];
    return data.map((json) => ApartmentModel.fromJson(json)).toList();

  } on DioException catch (e) {
    // إذا السيرفر رجّع 404 مع رسالة "لا توجد شقق"
    if (e.response?.statusCode == 404 &&
        e.response?.data["message"] == "لا توجد شقق متاحة حالياً") {
      print("⚠️ No apartments available (404)");
      return [];
    }

    print("❌ DioException: ${e.message}");
    throw Exception("Failed to load apartments");
  }
}
}