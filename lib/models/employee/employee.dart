import "package:json_annotation/json_annotation.dart";

import "../transaction/transaction.dart";

part "employee.g.dart";

@JsonSerializable(explicitToJson: true)
class Employee {

  @JsonKey(name: "_id")
  String id;

  String name;
  String designation;
  String? identity;

  List<int> count;
  List<Transaction> transactions;

  Employee({
    required this.id,
    required this.name,
    required this.designation,
    this.count = const [0, 0, 0],
    this.identity,
    this.transactions = const []
  });

  factory Employee.fromJson(Map<String, dynamic> json) => _$EmployeeFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}