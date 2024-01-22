// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactionItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionItem _$TransactionItemFromJson(Map<String, dynamic> json) =>
    TransactionItem(
      id: json['_id'] as String,
      item: Stationery.fromJson(json['item'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      type: json['type'] as String,
      reference: Reference.fromJson(json['reference'] as Map<String, dynamic>),
      remarks: json['remarks'] as String? ?? " ",
    );

Map<String, dynamic> _$TransactionItemToJson(TransactionItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'item': instance.item.toJson(),
      'quantity': instance.quantity,
      'type': instance.type,
      'remarks': instance.remarks,
      'reference': instance.reference.toJson(),
    };

Reference _$ReferenceFromJson(Map<String, dynamic> json) => Reference(
      supply: json['supply'] as String?,
      demand: json['demand'] as String?,
    );

Map<String, dynamic> _$ReferenceToJson(Reference instance) => <String, dynamic>{
      'supply': instance.supply,
      'demand': instance.demand,
    };
