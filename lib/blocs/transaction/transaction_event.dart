part of "transaction_bloc.dart";

@immutable

sealed class TransactionEvent {}

final class FetchTransactionList extends TransactionEvent {}