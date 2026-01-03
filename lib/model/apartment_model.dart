class ApartmentModel {
  final int id;
  final String city;
  final String governorate;
  final String rentPrice;
  final String apartmentSpace;
  final String rooms;
  final String floor;
  final String bathrooms;
  final String apartmentImage;  
  final String imageUrl;      

  ApartmentModel({
    required this.id,
    required this.city,
    required this.governorate,
    required this.rentPrice,
    required this.apartmentSpace,
    required this.rooms,
    required this.floor,
    required this.bathrooms,
    required this.apartmentImage,
    required this.imageUrl,
  });

  factory ApartmentModel.fromJson(Map<String, dynamic> json) {
    final apartment = json['data']['apartment'];
    return ApartmentModel(
      id: apartment['id'],
      city: apartment['city'],
      governorate: apartment['Governorate'],
      rentPrice: apartment['rent_price'],
      apartmentSpace: apartment['apartment_space'],
      rooms: apartment['rooms'],
      floor: apartment['floor'],
      bathrooms: apartment['bathrooms'],
      apartmentImage: apartment['apartment_image'], 
      imageUrl: json['data']['image_url'],         
    );
  }
}