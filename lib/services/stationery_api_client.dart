import "dart:convert";
import "dart:io";

import 'package:http/http.dart' as http;

import "package:records/constants/constants.dart";
import "package:records/models/stationery/stationery.dart";

class StationeryApiClient {
  final baseUrl = Constants.BASE_URL;
  final http.Client httpClient;

  StationeryApiClient({http.Client? httpClient}) : httpClient = httpClient ?? http.Client();

  Future<List<Stationery>> getAllStationery() async {
    final url = "$baseUrl/query/stationery/";
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

    final stationeryJson = jsonDecode(res.body) as List;
    final stationeryList = stationeryJson.map((e) => Stationery.fromJson(e)).toList();

    return stationeryList;
  }

  Future<Stationery> addStationery(name, quantity, image) async {
    final url = "$baseUrl/stationery/add";
    final res = await httpClient.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          "name": name,
          "quantity": quantity.toString(),
          "image": image
        },
      ),
    );

    if(res.statusCode != 200) {
      throw Exception(jsonDecode(res.body)["error"]);
    }
    final addedStationery = Stationery.fromJson(jsonDecode(res.body));
    return addedStationery;
  }

}
