part of "transaction_bloc.dart";

@immutable
sealed class TransactionState {}


final class TransactionInitial extends TransactionState {}

final class TransactionListLoaded extends TransactionState {
  final List<Transaction> transactionList;
  TransactionListLoaded(this.transactionList);

  TransactionListLoaded copyWith({
    List<Transaction>? transactionList
  }) {
    return TransactionListLoaded(transactionList?? this.transactionList);
  }
}

final class TransactionListFailure extends TransactionState {
  final String error;

  TransactionListFailure(this.error);
}

final class TransactionListLoading extends TransactionState {}