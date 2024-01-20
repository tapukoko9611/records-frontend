part of "stationery_bloc.dart";

@immutable
sealed class StationeryState {}


final class StationeryInitial extends StationeryState {}

final class StationeryListLoaded extends StationeryState {
  final List<Stationery> stationeryList;
  StationeryListLoaded(this.stationeryList);

  StationeryListLoaded copyWith({
    List<Stationery>? stationeryList
  }) {
    return StationeryListLoaded(stationeryList?? this.stationeryList);
  }
}

final class StationeryListFailure extends StationeryState {
  final String error;

  StationeryListFailure(this.error);
}

final class StationeryListLoading extends StationeryState {}


final class StationeryAddInitial extends StationeryState {}

final class StationeryAddSuccess extends StationeryState {
  final Stationery addedStationery;

  StationeryAddSuccess(this.addedStationery);
}

final class StationeryAddFailure extends StationeryState {
  final String error;

  StationeryAddFailure(this.error);
}

final class StationeryAddLoading extends StationeryState {}
