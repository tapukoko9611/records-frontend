part of "employee_bloc.dart";

@immutable
sealed class EmployeeEvent {}

final class FetchEmployeeList extends EmployeeEvent {}
