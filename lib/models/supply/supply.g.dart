// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Supply _$SupplyFromJson(Map<String, dynamic> json) => Supply(
      image: json['image'] as String? ?? '',
      supplier: json['supplier'] as String?,
      reference: json['reference'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      price: json['price'] as int?,
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SupplyToJson(Supply instance) => <String, dynamic>{
      'image': instance.image,
      'supplier': instance.supplier,
      'reference': instance.reference,
      'date': instance.date?.toIso8601String(),
      'price': instance.price,
      'transactions': instance.transactions?.map((e) => e.toJson()).toList(),
    };
