import "dart:convert";
import "dart:io";

import 'package:http/http.dart' as http;

import "package:records/constants/constants.dart";
import "package:records/models/skeleton/skeleton.dart";
import "package:records/models/transaction/transaction.dart";

class TransactionApiClient {
  final baseUrl = Constants.BASE_URL;
  final http.Client httpClient;

  TransactionApiClient({http.Client? httpClient}) : httpClient = httpClient ?? http.Client();

  Future<Skeleton> getAllTransactions() async {
    final url = "$baseUrl/query/transaction/";
    final res = await httpClient.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json"
        }
    );
    if(res.statusCode != 200) {
      throw Exception(jsonDecode(res.body)["error"]);
    }

    final skeletonJson = jsonDecode(res.body);
    final skeleton = Skeleton.fromJson(skeletonJson);
    // final transactionList = transactionJson.map((e) => Transaction.fromJson(e)).toList();

    return skeleton;
  }

  Future<Map> deleteTransaction(id, type) async {
    final url = "$baseUrl/transaction/delete/$id&$type";
    final res = await httpClient.delete(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        }
    );

    if(res.statusCode != 200) {
      throw Exception(jsonDecode(res.body)["error"]);
    } else {
      return jsonDecode(res.body);
    }
  }

}
