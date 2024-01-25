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


final class EmployeeUpdateInitial extends EmployeeState {}

final class EmployeeUpdateSuccess extends EmployeeState {
  final Map updatedEmployee;

  // EmployeeListLoaded({required this.employeeList});
  EmployeeUpdateSuccess(this.updatedEmployee);
}

final class EmployeeUpdateFailure extends EmployeeState {
  final String error;

  EmployeeUpdateFailure(this.error);
}

final class EmployeeUpdateLoading extends EmployeeState {}


final class EmployeeDeleteInitial extends EmployeeState {}

final class EmployeeDeleteSuccess extends EmployeeState {
  final Map deletedEmployee;

  // EmployeeListLoaded({required this.employeeList});
  EmployeeDeleteSuccess(this.deletedEmployee);
}

final class EmployeeDeleteFailure extends EmployeeState {
  final String error;

  EmployeeDeleteFailure(this.error);
}

final class EmployeeDeleteLoading extends EmployeeState {}


final class EmployeeRecordInitial extends EmployeeState {}

final class EmployeeRecordLoaded extends EmployeeState {
  final List<Employee> employeeListWithARecord;
  EmployeeRecordLoaded(this.employeeListWithARecord);

  EmployeeRecordLoaded copyWith({
    List<Employee>? employeeListWithARecord
  }) {
    return EmployeeRecordLoaded(employeeListWithARecord?? this.employeeListWithARecord);
  }
}

final class EmployeeRecordFailure extends EmployeeState {
  final String error;

  EmployeeRecordFailure(this.error);
}

final class EmployeeRecordLoading extends EmployeeState {}