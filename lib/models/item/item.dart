import "package:json_annotation/json_annotation.dart";

part "item.g.dart";

@JsonSerializable(explicitToJson: true)
class Item {
  String name;
  String category;

  Item({
    required this.name,
    required this.category
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}