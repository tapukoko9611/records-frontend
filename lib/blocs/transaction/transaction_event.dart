part of "transaction_bloc.dart";

@immutable
sealed class TransactionEvent {}

final class FetchTransactionList extends TransactionEvent {}

final class AddTransaction extends TransactionEvent {
  final Map<String, dynamic> transaction;

  AddTransaction({required this.transaction});
}

final class NewTransaction extends TransactionEvent{
  final Map transaction;

  NewTransaction({
    required this.transaction
});
}