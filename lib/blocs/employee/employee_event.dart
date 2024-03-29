part of "employee_bloc.dart";

@immutable
sealed class EmployeeEvent {}

final class FetchEmployeeList extends EmployeeEvent {}

final class AddEmployee extends EmployeeEvent {
  final String designation;
  final String name;
  final String identity;

  AddEmployee({
    required this.designation,
    required this.name,
    required this.identity
  });
}

final class UpdateEmployee extends EmployeeEvent {
  final String id;
  final String designation;
  final String name;
  final String identity;

  UpdateEmployee({
    required this.id,
    required this.designation,
    required this.name,
    required this.identity
  });
}

final class DeleteEmployee extends EmployeeEvent {
  final String id;

  DeleteEmployee({
    required this.id
  });
}

final class GetEmployeeRecord extends EmployeeEvent {
  final String id;

  GetEmployeeRecord({
    required this.id
  });
}
