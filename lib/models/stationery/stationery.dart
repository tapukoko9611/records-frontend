import "package:json_annotation/json_annotation.dart";

import "package:records/models/item/item.dart";

part "stationery.g.dart";

@JsonSerializable(explicitToJson: true)
class Stationery {

  @JsonKey(name: "_id")
  String? id;

  Item? item;
  int? quantity;

  List<String>? demand;
  List<String>? supply;

  @JsonKey(defaultValue: "https://imgs.search.brave.com/zXRp6Z2JMNEagn7FTUoCDRJhYMEagoduO18HCxwuRDI/rs:fit:500:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzA0Lzk0LzkxLzA3/LzM2MF9GXzQ5NDkx/MDc2OF85a1I5V1Zw/ZVk0bGlGRmNwUVpW/QnplN3ZvcWZNMFFF/Vy5qcGc")
  String? image;

  Stationery({
    this.id,
    this.item,
    this.quantity,
    this.image,
    this.demand,
    this.supply,
  });

  factory Stationery.fromJson(Map<String, dynamic> json) => _$StationeryFromJson(json);
  Map<String, dynamic> toJson() => _$StationeryToJson(this);

}
