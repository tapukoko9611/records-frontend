part of "employee_bloc.dart";

@immutable
sealed class EmployeeState {}


final class EmployeeInitial extends EmployeeState {}

final class EmployeeListLoaded extends EmployeeState {
  final List<Employee> employeeList;
  EmployeeListLoaded(this.employeeList);

  EmployeeListLoaded copyWith({
    List<Employee>? employeeList
  }) {
    return EmployeeListLoaded(employeeList?? this.employeeList);
  }
}

final class EmployeeListFailure extends EmployeeState {
  final String error;

  EmployeeListFailure(this.error);
}

final class EmployeeListLoading extends EmployeeState {}


final class EmployeeAddInitial extends EmployeeState {}

final class EmployeeAddSuccess extends EmployeeState {
  final Employee addedEmployee;

  // EmployeeListLoaded({required this.employeeList});
  EmployeeAddSuccess(this.addedEmployee);
}

final class EmployeeAddFailure extends EmployeeState {
  final String error;

  EmployeeAddFailure(this.error);
}

final class EmployeeAddLoading extends EmployeeState {}
