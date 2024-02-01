import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter/material.dart";
import "package:records/models/skeleton/skeleton.dart";

import "package:records/models/transaction/transaction.dart";
import "package:records/repositories/transaction_repository.dart";

part "transaction_event.dart";
part "transaction_state.dart";

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository transactionRepository;

  TransactionBloc(this.transactionRepository): super(TransactionInitial()) {
    on<FetchTransactionList>(_getTransactionList);
    on<NewTransaction>(_addTransaction);
  }

  void _getTransactionList(FetchTransactionList event, Emitter<TransactionState> emit) async {
    emit(TransactionListLoading());
    try {
      final skeleton = await transactionRepository.getAllTransactions();
      emit(TransactionListLoaded(skeleton));
    } catch(e) {
      emit(TransactionListFailure(e.toString()));
    }
  }

  void _addTransaction(NewTransaction event, Emitter<TransactionState> emit) async {
    final currentState = state;
    emit(TransactionAddLoading());
    try {
      final addedTransaction = await transactionRepository.addTransaction(event.transaction);
      if(currentState is TransactionListLoaded) {
        final List<Transaction> updatedList = List.from(currentState.skeleton.transactions!)..add(addedTransaction);
        final Skeleton updatedSkeleton = Skeleton(
          transactions: updatedList,
          employees: currentState.skeleton.employees,
          stationery: currentState.skeleton.stationery,
          suppliers: currentState.skeleton.suppliers
        );
        emit(TransactionAddSuccess(addedTransaction));
        await Future.delayed(const Duration(seconds: 1), () {
          return emit(currentState.copyWith(skeleton: updatedSkeleton));
        });
      }
    } catch (e) {
      if (currentState is TransactionListLoaded) {
        emit(TransactionAddFailure(e.toString()));
        await Future.delayed(const Duration(seconds: 3), () {
          return emit(currentState);
        });
      }
    }
  }
}