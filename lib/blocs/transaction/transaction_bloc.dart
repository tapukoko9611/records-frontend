import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter/material.dart";

import "package:records/models/transaction/transaction.dart";
import "package:records/repositories/transaction_repository.dart";

part "transaction_event.dart";
part "transaction_state.dart";

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository transactionRepository;

  TransactionBloc(this.transactionRepository): super(TransactionInitial()) {
    on<FetchTransactionList>(_getTransactionList);
  }

  void _getTransactionList(FetchTransactionList event, Emitter<TransactionState> emit) async {
    emit(TransactionListLoading());
    try {
      final transactionList = await transactionRepository.getAllTransactions();
      emit(TransactionListLoaded(transactionList));
    } catch(e) {
      emit(TransactionListFailure(e.toString()));
    }
  }

}