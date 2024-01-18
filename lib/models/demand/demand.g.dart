// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Demand _$DemandFromJson(Map<String, dynamic> json) => Demand(
      image: json['image'] as String? ?? '',
      employee: json['employee'] == null
          ? null
          : Employee.fromJson(json['employee'] as Map<String, dynamic>),
      reference: json['reference'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DemandToJson(Demand instance) => <String, dynamic>{
      'image': instance.image,
      'employee': instance.employee?.toJson(),
      'reference': instance.reference,
      'date': instance.date?.toIso8601String(),
      'transactions': instance.transactions?.map((e) => e.toJson()).toList(),
    };
