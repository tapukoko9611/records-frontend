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

final class UpdateStationery extends StationeryEvent {
  final String id;
  final String name;
  final int quantity;
  final String image;

  UpdateStationery({
    required this.id,
    required this.name,
    required this.quantity,
    required this.image
  });
}

final class DeleteStationery extends StationeryEvent {
  final String id;

  DeleteStationery({
    required this.id
  });
}

final class GetStationeryRecord extends StationeryEvent {
  final String id;

  GetStationeryRecord({
    required this.id
  });
}