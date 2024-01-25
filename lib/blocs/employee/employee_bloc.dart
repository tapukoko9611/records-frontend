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
    on<UpdateEmployee>(_updateEmployee);
    on<DeleteEmployee>(_deleteEmployee);
    on<GetEmployeeRecord>(_getEmployeeRecord);
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
      if(currentState is EmployeeRecordLoaded) {
        final List<Employee> updatedList = List.from(currentState.employeeListWithARecord)..add(addedEmployee);
        emit(EmployeeAddSuccess(addedEmployee));
        // emit(currentState.copyWith(employeeList: updatedList));
        await Future.delayed(const Duration(seconds: 1), () {
          return emit(currentState.copyWith(employeeListWithARecord: updatedList));
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

  void _updateEmployee(UpdateEmployee event, Emitter<EmployeeState> emit) async {
    final currentState = state;
    emit(EmployeeUpdateLoading());
    try {
      final updatedEmployee = await employeeRepository.updateEmployee(event.id, event.designation, event.name, event.identity);
      // if(currentState is EmployeeListLoaded) {
      //   final List<Employee> updatedList = List.from(currentState.employeeList);
      //   updatedList.map((employee) {
      //     if(employee.id==event.id) {
      //       return Employee(
      //           id: employee.id,
      //           name: updatedEmployee["name"],
      //           designation: updatedEmployee["designation"],
      //           identity: updatedEmployee["identity"],
      //           count: employee.count,
      //           transactions: employee.transactions
      //       );
      //     }
      //     else {
      //       return employee;
      //     }
      //   });
      //   emit(EmployeeUpdateSuccess(updatedEmployee));
      //   await Future.delayed(const Duration(seconds: 1), () {
      //     return emit(currentState.copyWith(employeeList: updatedList));
      //   });
      // }
      if(currentState is EmployeeRecordLoaded) {
        final List<Employee> updatedEmployeeListWithARecord = List.from(currentState.employeeListWithARecord.map((employee) {
          if(employee.id == event.id) {
            return Employee(
                id: employee.id,
                name: updatedEmployee["name"],
                designation: updatedEmployee["designation"],
                identity: updatedEmployee["identity"],
                count: employee.count,
                transactions: employee.transactions
            );
          } else {
            return employee;
          }
        }));
        emit(EmployeeUpdateSuccess(updatedEmployee));
        await Future.delayed(const Duration(seconds: 3), () {
          return emit(currentState.copyWith(employeeListWithARecord: updatedEmployeeListWithARecord));
        });
      }
    } catch(e) {
      if(currentState is EmployeeRecordLoaded) {
        emit(EmployeeUpdateFailure(e.toString()));
        await Future.delayed(const Duration(seconds: 3), () {
          return emit(currentState);
        });
      }
    }
  }

  void _deleteEmployee(DeleteEmployee event, Emitter<EmployeeState> emit) async {
    final currentState = state;
    emit(EmployeeDeleteLoading());
    try {
      final deletedEmployee = await employeeRepository.deleteEmployee(event.id);
      // if(currentState is EmployeeListLoaded) {
      //   final List<Employee> updatedList = List.from(currentState.employeeList)..removeWhere((employee) => employee.id==event.id);
      //   emit(EmployeeDeleteSuccess(deletedEmployee));
      //   await Future.delayed(const Duration(seconds: 1), () {
      //     return emit(currentState.copyWith(employeeList: updatedList));
      //   });
      // }
      // if(currentState is EmployeeRecordLoaded) {
      // print("Employee delete bloc Screen state before: ");
      // print(currentState);
        if(currentState is EmployeeRecordLoaded) {
          emit(EmployeeDeleteSuccess(deletedEmployee));
          // final List<Employee> updatedList = List.from(currentState.employeeListWithARecord)..removeWhere((employee) => employee.id==event.id);
          currentState.employeeListWithARecord.removeWhere((employee) => employee.id==event.id);
          emit(EmployeeDeleteSuccess(deletedEmployee));
          await Future.delayed(const Duration(seconds: 4), () {
            return emit(EmployeeListLoaded(currentState.employeeListWithARecord)); //.copyWith(employeeList: updatedList));
          });
        }
        // await Future.delayed(const Duration(seconds: 2), () {
        //   return _getEmployeeList(FetchEmployeeList(), emit);
        // });

      // print("Employee delete bloc Screen state after: ");
      // print(state);
      // }
    } catch(e) {
      // if(currentState is EmployeeListLoaded) {
      //   emit(EmployeeDeleteFailure(e.toString()));
      //   await Future.delayed(const Duration(seconds: 3), () {
      //     return emit(currentState);
      //   });
      // }
      if(currentState is EmployeeRecordLoaded) {
        emit(EmployeeDeleteFailure(e.toString()));
        await Future.delayed(const Duration(seconds: 3), () {
          return emit(currentState);
        });
      }
    }
  }

  void _getEmployeeRecord(GetEmployeeRecord event, Emitter<EmployeeState> emit) async {
    final currentState = state;
    emit(EmployeeRecordLoading());
    try {
      if(currentState is EmployeeListLoaded) {
        final employeeRecord = await employeeRepository.getEmployeeRecord(event.id);
        print(List.from(currentState.employeeList));
        final List<Employee> employeeListWithARecord = List.from(currentState.employeeList.map((employee) {
          if(employee.id == event.id) {
            return Employee(
                id: employee.id,
                name: employee.name,
                designation: employee.designation,
                identity: employee.identity,
                count: employee.count,
                transactions: employeeRecord.transactions
            );
          } else {
            return employee;
          }
        }));
        emit(EmployeeRecordLoaded(employeeListWithARecord));
      }
      if(currentState is EmployeeRecordLoaded) {
        final employeeRecord = await employeeRepository.getEmployeeRecord(event.id);
        print(List.from(currentState.employeeListWithARecord));
        final List<Employee> employeeListWithARecord = List.from(currentState.employeeListWithARecord.map((employee) {
          if(employee.id == event.id) {
            return Employee(
                id: employee.id,
                name: employee.name,
                designation: employee.designation,
                identity: employee.identity,
                count: employee.count,
                transactions: employeeRecord.transactions
            );
          } else {
            return employee;
          }
        }));
        emit(EmployeeRecordLoaded(employeeListWithARecord));
      }
    } catch(e) {
      emit(EmployeeRecordFailure(e.toString()));
    }
  }

}