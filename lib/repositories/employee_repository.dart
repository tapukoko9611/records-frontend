import "package:records/models/employee/employee.dart";
import "package:records/services/employee_api_client.dart";

class EmployeeRepository {
  final EmployeeApiClient employeeApiClient;

  EmployeeRepository({EmployeeApiClient? employeeApiClient}): employeeApiClient = employeeApiClient ?? EmployeeApiClient();

  Future<List<Employee>> getAllEmployees() {
    return employeeApiClient.getAllEmployees();
  }

  Future<Employee> addEmployee(designation, name, identity) {
    return employeeApiClient.addEmployee(designation, name, identity);
  }

}