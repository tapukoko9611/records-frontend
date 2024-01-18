import "dart:convert";
import "dart:io";

import 'package:http/http.dart' as http;

import "package:records/constants/constants.dart";
import "package:records/models/employee/employee.dart";

class EmployeeApiClient {
  final baseUrl = Constants.BASE_URL;
  final http.Client httpClient;

  EmployeeApiClient({http.Client? httpClient}) : httpClient = httpClient ?? http.Client();

  Future<List<Employee>> getAllEmployees() async {
    final url = "$baseUrl/query/employee/";
    final res = await httpClient.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptHeader: "application/json"
      }
    );
    if(res.statusCode != 200) {
      print("Error: $res.msg");
      throw Exception("Error: $res.msg");
    }

    final employeeJson = jsonDecode(res.body) as List;
    final employeeList = employeeJson.map((e) => Employee.fromJson(e)).toList();

    return employeeList;
  }

}
