// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      id: json['_id'] as String,
      name: json['name'] as String,
      designation: json['designation'] as String,
      count: (json['count'] as List<dynamic>?)?.map((e) => e as int).toList() ??
          const [0, 0, 0],
      identity: json['identity'] as String?,
      transactions: (json['transactions'] as List<dynamic>?)
              ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'designation': instance.designation,
      'identity': instance.identity,
      'count': instance.count,
      'transactions': instance.transactions.map((e) => e.toJson()).toList(),
    };
