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


final class StationeryUpdateSuccess extends StationeryState {
  final Map updatedStationery;

  // StationeryListLoaded({required this.StationeryList});
  StationeryUpdateSuccess(this.updatedStationery);
}

final class StationeryUpdateFailure extends StationeryState {
  final String error;

  StationeryUpdateFailure(this.error);
}

final class StationeryUpdateLoading extends StationeryState {}


final class StationeryDeleteInitial extends StationeryState {}

final class StationeryDeleteSuccess extends StationeryState {
  final Map deletedStationery;

  // StationeryListLoaded({required this.StationeryList});
  StationeryDeleteSuccess(this.deletedStationery);
}

final class StationeryDeleteFailure extends StationeryState {
  final String error;

  StationeryDeleteFailure(this.error);
}

final class StationeryDeleteLoading extends StationeryState {}


final class StationeryRecordInitial extends StationeryState {}

final class StationeryRecordLoaded extends StationeryState {
  final List<Stationery> stationeryListWithARecord;
  StationeryRecordLoaded(this.stationeryListWithARecord);

  StationeryRecordLoaded copyWith({
    List<Stationery>? stationeryListWithARecord
  }) {
    return StationeryRecordLoaded(stationeryListWithARecord?? this.stationeryListWithARecord);
  }
}

final class StationeryRecordFailure extends StationeryState {
  final String error;

  StationeryRecordFailure(this.error);
}

final class StationeryRecordLoading extends StationeryState {}