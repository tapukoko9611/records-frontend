// import "package:json_annotation/json_annotation.dart";
//
// import "package:records/models/employee/employee.dart";
// import "package:records/models/transaction/transaction.dart";
//
// part "demand.g.dart";
//
// @JsonSerializable(explicitToJson: true)
// class Demand {
//
//   @JsonKey(defaultValue: "")
//   String? image;
//
//   Employee? employee;
//   String? reference;
//   DateTime? date;
//
//   List<Transaction>? transactions;
//
//   Demand({
//     this.image,
//     this.employee,
//     this.reference,
//     this.date,
//     this.transactions
//   });
//
//   factory Demand.fromJson(Map<String, dynamic> json) => _$DemandFromJson(json);
//   Map<String, dynamic> toJson() => _$DemandToJson(this);
// }