import "package:records/models/transaction/transaction.dart";
import "package:records/services/transaction_api_client.dart";

class TransactionRepository {
  final TransactionApiClient transactionApiClient;

  TransactionRepository({TransactionApiClient? transactionApiClient}): transactionApiClient = transactionApiClient ?? TransactionApiClient();

  Future<List<Transaction>> getAllTransactions() {
    return transactionApiClient.getAllTransactions();
  }
}