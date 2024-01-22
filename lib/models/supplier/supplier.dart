import "package:json_annotation/json_annotation.dart";

part "supplier.g.dart";

@JsonSerializable(explicitToJson: true)
class Supplier {

  @JsonKey(name: "_id")
  String id;

  String name;
  String organization;
  String? identity;

  List<int> count;

  Supplier({
    required this.id,
    required this.name,
    required this.organization,
    this.count = const [0, 0, 0],
    this.identity,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) => _$SupplierFromJson(json);
  Map<String, dynamic> toJson() => _$SupplierToJson(this);
}