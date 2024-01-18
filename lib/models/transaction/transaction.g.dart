// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: json['_id'] as String?,
      item: json['item'] == null
          ? null
          : Item.fromJson(json['item'] as Map<String, dynamic>),
      quantity: json['quantity'] as int?,
      type: json['type'] as String?,
      reference: json['reference'] == null
          ? null
          : Reference.fromJson(json['reference'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'item': instance.item?.toJson(),
      'quantity': instance.quantity,
      'type': instance.type,
      'reference': instance.reference?.toJson(),
    };

Reference _$ReferenceFromJson(Map<String, dynamic> json) => Reference(
      supply: json['supply'] as String,
      demand: json['demand'] as String,
    );

Map<String, dynamic> _$ReferenceToJson(Reference instance) => <String, dynamic>{
      'supply': instance.supply,
      'demand': instance.demand,
    };
