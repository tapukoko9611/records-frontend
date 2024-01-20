import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter/material.dart";

import "package:records/models/stationery/stationery.dart";
import "package:records/repositories/stationery_repository.dart";

part "stationery_event.dart";
part "stationery_state.dart";

class StationeryBloc extends Bloc<StationeryEvent, StationeryState> {
  final StationeryRepository stationeryRepository;

  StationeryBloc(this.stationeryRepository): super(StationeryInitial()) {
    on<FetchStationeryList>(_getStationeryList);
    on<AddStationery>(_addStationery);
  }

  void _getStationeryList(FetchStationeryList event, Emitter<StationeryState> emit) async {
    emit(StationeryListLoading());
    try {
      final stationeryList = await stationeryRepository.getAllStationery();
      emit(StationeryListLoaded(stationeryList));
    } catch(e) {
      emit(StationeryListFailure(e.toString()));
    }
  }

  void _addStationery(AddStationery event, Emitter<StationeryState> emit) async {
    final currentState = state;
    emit(StationeryAddLoading());
    try {
      final addedStationery = await stationeryRepository.addStationery(event.name, event.quantity, event.image);
      if(currentState is StationeryListLoaded) {
        final List<Stationery> updatedList = List.from(currentState.stationeryList)..add(addedStationery);
        emit(StationeryAddSuccess(addedStationery));
        await Future.delayed(const Duration(seconds: 1), () {
          return emit(currentState.copyWith(stationeryList: updatedList));
        });
      }
    } catch(e) {
      if(currentState is StationeryListLoaded) {
        emit(StationeryAddFailure(e.toString()));
        await Future.delayed(const Duration(seconds: 3), () {
          return emit(currentState);
        });
      }
    }
  }
}