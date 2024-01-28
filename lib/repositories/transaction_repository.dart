import "package:records/models/skeleton/skeleton.dart";
import "package:records/models/transaction/transaction.dart";
import "package:records/services/transaction_api_client.dart";

class TransactionRepository {
  final TransactionApiClient transactionApiClient;

  TransactionRepository({TransactionApiClient? transactionApiClient}): transactionApiClient = transactionApiClient ?? TransactionApiClient();

  Future<Skeleton> getAllTransactions() {
    return transactionApiClient.getAllTransactions();
  }

  Future<Map> deleteTransaction(id, type) {
    return transactionApiClient.deleteTransaction(id, type);
  }
}