import "package:json_annotation/json_annotation.dart";

import "package:records/models/item/item.dart";

part "transaction.g.dart";

@JsonSerializable(explicitToJson: true)
class Transaction {

  @JsonKey(name: "_id")
  String? id;

  Item? item;
  int? quantity;
  String? type;
  Reference? reference;

  Transaction({
    this.id,
    this.item,
    this.quantity,
    this.type,
    this.reference
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Reference {
  String supply;
  String demand;

  Reference({
    required this.supply,
    required this.demand
  });

  factory Reference.fromJson(Map<String, dynamic> json) => _$ReferenceFromJson(json);
  Map<String, dynamic> toJson() => _$ReferenceToJson(this);
}