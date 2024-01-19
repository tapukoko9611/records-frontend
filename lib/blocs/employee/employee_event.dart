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