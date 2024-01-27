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
    on<UpdateStationery>(_updateStationery);
    on<DeleteStationery>(_deleteStationery);
    on<GetStationeryRecord>(_getStationeryRecord);
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
      if(currentState is StationeryRecordLoaded) {
        final List<Stationery> updatedList = List.from(currentState.stationeryListWithARecord)..add(addedStationery);
        emit(StationeryAddSuccess(addedStationery));
        // emit(currentState.copyWith(StationeryList: updatedList));
        await Future.delayed(const Duration(seconds: 1), () {
          return emit(currentState.copyWith(stationeryListWithARecord: updatedList));
        });
      }
    } catch(e) {
      if(currentState is StationeryListLoaded) {
        emit(StationeryAddFailure(e.toString()));
        await Future.delayed(const Duration(seconds: 3), () {
          return emit(currentState);
        });
      }
      if(currentState is StationeryRecordLoaded) {
        emit(StationeryAddFailure(e.toString()));
        await Future.delayed(const Duration(seconds: 3), () {
          return emit(currentState);
        });
      }
    }
  }

  void _updateStationery(UpdateStationery event, Emitter<StationeryState> emit) async {
    final currentState = state;
    emit(StationeryUpdateLoading());
    try {
      final updatedStationery = await stationeryRepository.updateStationery(event.id, event.name, event.quantity, event.image);
      if(currentState is StationeryRecordLoaded) {
        final List<Stationery> updatedStationeryListWithARecord = List.from(currentState.stationeryListWithARecord.map((stationery) {
          if(stationery.id == event.id) {
            return Stationery(
                id: stationery.id,
                name: updatedStationery["name"],
                quantity: updatedStationery["quantity"],
                image: updatedStationery["image"],
                demand: stationery.demand,
                supply: stationery.supply,
                transactions: stationery.transactions
            );
          } else {
            return stationery;
          }
        }));
        emit(StationeryUpdateSuccess(updatedStationery));
        await Future.delayed(const Duration(seconds: 3), () {
          return emit(currentState.copyWith(stationeryListWithARecord: updatedStationeryListWithARecord));
        });
      }
    } catch(e) {
      if(currentState is StationeryRecordLoaded) {
        emit(StationeryUpdateFailure(e.toString()));
        await Future.delayed(const Duration(seconds: 3), () {
          return emit(currentState);
        });
      }
    }
  }

  void _deleteStationery(DeleteStationery event, Emitter<StationeryState> emit) async {
    final currentState = state;
    emit(StationeryDeleteLoading());
    try {
      final deletedStationery = await stationeryRepository.deleteStationery(event.id);
        if(currentState is StationeryRecordLoaded) {
          currentState.stationeryListWithARecord.removeWhere((stationery) => stationery.id==event.id);
          emit(StationeryDeleteSuccess(deletedStationery));
          await Future.delayed(const Duration(seconds: 4), () {
            return emit(StationeryListLoaded(currentState.stationeryListWithARecord));
          });
        }
    } catch(e) {
      if(currentState is StationeryRecordLoaded) {
        emit(StationeryDeleteFailure(e.toString()));
        await Future.delayed(const Duration(seconds: 3), () {
          return emit(currentState);
        });
      }
    }
  }

  void _getStationeryRecord(GetStationeryRecord event, Emitter<StationeryState> emit) async {
    final currentState = state;
    emit(StationeryRecordLoading());
    try {
      if(currentState is StationeryListLoaded) {
        final stationeryRecord = await stationeryRepository.getStationeryRecord(event.id);
        final List<Stationery> stationeryListWithARecord = List.from(currentState.stationeryList.map((stationery) {
          if(stationery.id == event.id) {
            return Stationery(
                id: stationery.id,
                name: stationery.name,
                quantity: stationery.quantity,
                demand: stationery.demand,
                supply: stationery.supply,
                transactions: stationeryRecord.transactions
            );
          } else {
            return stationery;
          }
        }));
        emit(StationeryRecordLoaded(stationeryListWithARecord));
      }
      if(currentState is StationeryRecordLoaded) {
        final stationeryRecord = await stationeryRepository.getStationeryRecord(event.id);
        print(stationeryRecord.transactions);
        final List<Stationery> stationeryListWithARecord = List.from(currentState.stationeryListWithARecord.map((stationery) {
          if(stationery.id == event.id) {
            return Stationery(
                id: stationery.id,
                name: stationery.name,
                quantity: stationery.quantity,
                demand: stationery.demand,
                supply: stationery.supply,
                transactions: stationeryRecord.transactions
            );
          } else {
            return stationery;
          }
        }));
        emit(StationeryRecordLoaded(stationeryListWithARecord));
      }
    } catch(e) {
      emit(StationeryRecordFailure(e.toString()));
    }
  }
}