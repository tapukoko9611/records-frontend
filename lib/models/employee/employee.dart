import "package:json_annotation/json_annotation.dart";

part "employee.g.dart";

@JsonSerializable(explicitToJson: true)
class Employee {

  @JsonKey(name: "_id")
  String id;

  String name;
  String designation;
  String? identity;

  List<int> count;

  Employee({
    required this.id,
    required this.name,
    required this.designation,
    required this.count,
    this.identity,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => _$EmployeeFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}