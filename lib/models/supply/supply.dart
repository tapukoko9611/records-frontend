import "package:json_annotation/json_annotation.dart";

import "package:records/models/transaction/transaction.dart";

part "supply.g.dart";

@JsonSerializable(explicitToJson: true)
class Supply {

  @JsonKey(defaultValue: "")
  String? image;

  String? supplier;
  String? reference;
  DateTime? date;
  int? price;

  List<Transaction>? transactions;

  Supply({
    this.image,
    this.supplier,
    this.reference,
    this.date,
    this.price,
    this.transactions
  });

  factory Supply.fromJson(Map<String, dynamic> json) => _$SupplyFromJson(json);
  Map<String, dynamic> toJson() => _$SupplyToJson(this);
}