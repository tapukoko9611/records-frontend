// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skeleton.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Skeleton _$SkeletonFromJson(Map<String, dynamic> json) => Skeleton(
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      employees: (json['employees'] as List<dynamic>?)
          ?.map((e) => Employee.fromJson(e as Map<String, dynamic>))
          .toList(),
      suppliers: (json['suppliers'] as List<dynamic>?)
          ?.map((e) => Supplier.fromJson(e as Map<String, dynamic>))
          .toList(),
      stationery: (json['stationery'] as List<dynamic>?)
          ?.map((e) => Stationery.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SkeletonToJson(Skeleton instance) => <String, dynamic>{
      'transactions': instance.transactions?.map((e) => e.toJson()).toList(),
      'employees': instance.employees?.map((e) => e.toJson()).toList(),
      'suppliers': instance.suppliers?.map((e) => e.toJson()).toList(),
      'stationery': instance.stationery?.map((e) => e.toJson()).toList(),
    };
