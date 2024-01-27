import "package:json_annotation/json_annotation.dart";

import "../transaction/transaction.dart";

part "stationery.g.dart";

@JsonSerializable(explicitToJson: true)
class Stationery {

  @JsonKey(name: "_id")
  String id;

  String name;
  int quantity;

  List<int> demand;
  List<int> supply;

  @JsonKey(defaultValue: "https://imgs.search.brave.com/zXRp6Z2JMNEagn7FTUoCDRJhYMEagoduO18HCxwuRDI/rs:fit:500:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzA0Lzk0LzkxLzA3/LzM2MF9GXzQ5NDkx/MDc2OF85a1I5V1Zw/ZVk0bGlGRmNwUVpW/QnplN3ZvcWZNMFFF/Vy5qcGc")
  String? image;
  List<Transaction> transactions;

  Stationery({
    required this.id,
    required this.name,
    required this.quantity,
    this.image = "https://imgs.search.brave.com/zXRp6Z2JMNEagn7FTUoCDRJhYMEagoduO18HCxwuRDI/rs:fit:500:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzA0Lzk0LzkxLzA3/LzM2MF9GXzQ5NDkx/MDc2OF85a1I5V1Zw/ZVk0bGlGRmNwUVpW/QnplN3ZvcWZNMFFF/Vy5qcGc",
    this.demand = const [0, 0 ,0],
    this.supply = const [0, 0, 0],
    this.transactions = const []
  });

  factory Stationery.fromJson(Map<String, dynamic> json) => _$StationeryFromJson(json);
  Map<String, dynamic> toJson() => _$StationeryToJson(this);

}
