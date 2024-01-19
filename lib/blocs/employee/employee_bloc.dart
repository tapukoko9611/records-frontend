import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter/material.dart";

import "package:records/models/employee/employee.dart";
import "package:records/repositories/employee_repository.dart";

part "employee_event.dart";
part "employee_state.dart";

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository employeeRepository;

  EmployeeBloc(this.employeeRepository): super(EmployeeInitial()) {
    on<FetchEmployeeList>(_getEmployeeList);
    on<AddEmployee>(_addEmployee);
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

  void _addEmployee(AddEmployee event, Emitter<EmployeeState> emit) async {
    final currentState = state;
    emit(EmployeeAddLoading());
    try {
      final addedEmployee = await employeeRepository.addEmployee(event.designation, event.name, event.identity);
      if(currentState is EmployeeListLoaded) {
        final List<Employee> updatedList = List.from(currentState.employeeList)..add(addedEmployee);
        emit(EmployeeAddSuccess(addedEmployee));
        // emit(currentState.copyWith(employeeList: updatedList));
        await Future.delayed(const Duration(seconds: 1), () {
          return emit(currentState.copyWith(employeeList: updatedList));
        });
      }
    } catch(e) {
      if(currentState is EmployeeListLoaded) {
        emit(EmployeeAddFailure(e.toString()));
        await Future.delayed(const Duration(seconds: 3), () {
          return emit(currentState);
        });
      }
    }
  }
}