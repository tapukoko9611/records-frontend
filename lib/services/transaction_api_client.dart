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

  Future<Transaction> addTransaction({type, person, date, reference, remarks, price=0, list}) async {
    final url = "$baseUrl/transaction/${type=="DEMAND"? "demand": "supply"}";
    final res = await httpClient.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      },
      body: jsonEncode(
        {
          type=="DEMAND"? "employee": "supplier": person,
          "reference": reference,
          "date": date.toString(),
          "remarks": remarks,
          "list": list,
          "image": "",
          "price": price
        },
      ),
    );

    if(res.statusCode != 200) {
      throw Exception(jsonDecode(res.body)["error"]);
    }
    print(res.body);
    final addedTransaction = Transaction.fromJson(jsonDecode(res.body));
    return addedTransaction;
  }

}
