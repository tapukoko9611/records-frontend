import "package:json_annotation/json_annotation.dart";
import "package:records/models/employee/employee.dart";
import "package:records/models/stationery/stationery.dart";
import "package:records/models/supplier/supplier.dart";
import "package:records/models/transaction/transaction.dart";

part "skeleton.g.dart";

@JsonSerializable(explicitToJson: true)
class Skeleton {

  List<Transaction>? transactions;
  List<Employee>? employees;
  List<Supplier>? suppliers;
  List<Stationery>? stationery;

  Skeleton({
    this.transactions,
    this.employees,
    this.suppliers,
    this.stationery
    });

  factory Skeleton.fromJson(Map<String, dynamic> json) => _$SkeletonFromJson(json);
  Map<String, dynamic> toJson() => _$SkeletonToJson(this);
}