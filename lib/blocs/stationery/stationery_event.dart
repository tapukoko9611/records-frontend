part of "stationery_bloc.dart";

@immutable
sealed class StationeryEvent {}

final class FetchStationeryList extends StationeryEvent {}

final class AddStationery extends StationeryEvent {
  final String name;
  final int quantity;
  final String image;

  AddStationery({
    required this.name,
    required this.quantity,
    required this.image
  });
}