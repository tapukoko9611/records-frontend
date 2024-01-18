import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter/material.dart";

import "package:records/models/employee/employee.dart";
import "package:records/repositories/employee_repository.dart";

part "employee_event.dart";
part "employee_state.dart";

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository employeeRepository;

  EmployeeBloc(this.employeeRepository): super(EmployeeListInitial()) {
    on<FetchEmployeeList>(_getEmployeeList);
  }

  void _getEmployeeList(FetchEmployeeList event, Emitter<EmployeeState> emit) async {
    emit(EmployeeListLoading());
    try {
      final employeeList = await employeeRepository.getAllEmployees();
      // emit(EmployeeListLoaded(employeeList: employeeList));
      emit(EmployeeListLoaded(employeeList));
    } catch(e) {
      emit(EmployeeListFailure(e.toString()));
    }
  }
}