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
      throw Exception(jsonDecode(res.body)["error"]);
    }

    final employeeJson = jsonDecode(res.body) as List;
    final employeeList = employeeJson.map((e) => Employee.fromJson(e)).toList();

    return employeeList;
  }

  Future<Employee> addEmployee(designation, name, identity) async {
    final url = "$baseUrl/employee/add";
    final res = await httpClient.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          "designation": designation,
          "name": name,
          "identity": identity
        },
      ),
    );

    if(res.statusCode != 200) {
      throw Exception(jsonDecode(res.body)["error"]);
    }
    final addedEmployee = Employee.fromJson(jsonDecode(res.body));
    return addedEmployee;
  }

  Future<Map> updateEmployee(id, designation, name, identity) async {
    final url = "$baseUrl/employee/update/$id";
    final res = await httpClient.put(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      },
      body: jsonEncode(
        <String, String>{
          "designation": designation,
          "name": name,
          "identity": identity
        },
      ),
    );

    if(res.statusCode != 200) {
      throw Exception(jsonDecode(res.body)["error"]);
    }
    final updatedEmployee = jsonDecode(res.body);
    return updatedEmployee;
  }

  Future<Map> deleteEmployee(id) async {
    final url = "$baseUrl/employee/delete/$id";
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

  Future<Employee> getEmployeeRecord(id) async {
    final url = "$baseUrl/query/employee/$id";
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

    final employeeJson = jsonDecode(res.body);
    final employeeRecord = Employee.fromJson(employeeJson);

    return employeeRecord;
  }

}
