/*import 'package:booker/model/apartment_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


Dio dio = Dio();

Future<ApartmentModel?> getApartmentdetails(int id) async {
  try {
    Response response = await dio.get(
      "https://dummyjson.com/c/e1a8-ac7e-4b5a-a6f2/$id",
    );
    final apartmentJson = response.data;
    final apartment = ApartmentModel.fromMap(apartmentJson);
    return apartment;
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }
}*/