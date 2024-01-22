import "package:json_annotation/json_annotation.dart";
import "package:records/models/stationery/stationery.dart";

part "transactionItem.g.dart";

@JsonSerializable(explicitToJson: true)
class TransactionItem {

  @JsonKey(name: "_id")
  String id;

  @JsonKey(name: "item")
  Stationery item;
  int quantity;
  String type;
  String remarks;
  Reference reference;

  TransactionItem({
    required this.id,
    required this.item,
    required this.quantity,
    required this.type,
    required this.reference,
    this.remarks = " "
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) => _$TransactionItemFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Reference {
  String? supply;
  String? demand;

  Reference({
    this.supply,
    this.demand
  });

  factory Reference.fromJson(Map<String, dynamic> json) => _$ReferenceFromJson(json);
  Map<String, dynamic> toJson() => _$ReferenceToJson(this);
}