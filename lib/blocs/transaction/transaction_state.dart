part of "transaction_bloc.dart";

@immutable
sealed class TransactionState {}

final class TransactionInitial extends TransactionState {}

final class TransactionListLoaded extends TransactionState {
  final Skeleton skeleton;
  TransactionListLoaded(this.skeleton);

  TransactionListLoaded copyWith({
    Skeleton? skeleton
  }) {
    return TransactionListLoaded(skeleton?? this.skeleton);
  }
}

final class TransactionListFailure extends TransactionState {
  final String error;

  TransactionListFailure(this.error);
}

final class TransactionListLoading extends TransactionState {}