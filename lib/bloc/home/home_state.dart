import 'package:booker/model/apartment_model.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ApartmentModel> apartments;

  const HomeLoaded(this.apartments);
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
}