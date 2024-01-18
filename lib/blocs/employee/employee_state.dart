part of "employee_bloc.dart";

@immutable
sealed class EmployeeState {}


final class EmployeeListInitial extends EmployeeState {}

final class EmployeeListLoaded extends EmployeeState {
  final List<Employee> employeeList;

  // EmployeeListLoaded({required this.employeeList});
  EmployeeListLoaded(this.employeeList);
}

final class EmployeeListFailure extends EmployeeState {
  final String error;

  EmployeeListFailure(this.error);
}

final class EmployeeListLoading extends EmployeeState {}
