// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

/////////////////////////////////////////////////////

@JsonSerializable()
class InOut extends Equatable {
  final int id;
  final DateTime date;

  final int subRef;
  final String? subName;

  final int DocID;

  final bool type;
  final double amount;
  final double RecPayAmount;

  final int customerRef;
  final String? customerName;
  final int visitorRef;

  final int currencyRef;
  final double currencyRatioM;
  final double currencyRatioD;

  final String description;

  SyncFlag syncFlag = SyncFlag.NON;

  InOut({
    required this.id,
    required this.date,
    required this.subRef,
    required this.subName,
    required this.DocID,
    required this.type,
    required this.amount,
    required this.RecPayAmount,
    required this.customerRef,
    required this.customerName,
    required this.visitorRef,
    required this.currencyRef,
    required this.currencyRatioM,
    required this.currencyRatioD,
    required this.description,
    this.syncFlag = SyncFlag.NON,
  });

  InOut.NewInOut(bool type, {int? id})
    : this(
        id: 0,
        date: DateTime.now(),
        subRef: 0,
        subName: null,
        DocID: 0,
        type: type,
        amount: 0,
        RecPayAmount: 0,
        customerRef: 0,
        customerName: null,
        visitorRef: Auth.user.customerId,
        currencyRef: defCrrency.id,
        currencyRatioM: 1,
        currencyRatioD: 1,
        description: '',
      );

  InOut copyWith({
    int? id,
    DateTime? date,
    int? subRef,
    String? subName,
    int? DocID,
    bool? type,
    double? amount,
    double? RecPayAmount,
    int? customerRef,
    String? customerName,
    int? visitorRef,
    SyncFlag? syncFlag,
    int? currencyRef,
    double? currencyRatioM,
    double? currencyRatioD,
    String? description,
  }) => InOut(
    id: id ?? this.id,
    date: date ?? this.date,
    subRef: subRef ?? this.subRef,
    subName: subName ?? this.subName,
    DocID: DocID ?? this.DocID,
    type: type ?? this.type,
    amount: amount ?? this.amount,
    RecPayAmount: RecPayAmount ?? this.RecPayAmount,
    customerRef: customerRef ?? this.customerRef,
    customerName: customerName ?? this.customerName,
    visitorRef: visitorRef ?? this.visitorRef,
    currencyRef: currencyRef ?? this.currencyRef,
    currencyRatioM: currencyRatioM ?? this.currencyRatioM,
    currencyRatioD: currencyRatioD ?? this.currencyRatioD,
    description: description ?? this.description,
    syncFlag: syncFlag ?? this.syncFlag,
  );

  factory InOut.fromJson(Map<String, dynamic> json) => _$InOutFromJson(json);
  Map<String, dynamic> toJson() => _$InOutToJson(this);

  static InOut _$InOutFromJson(Map<String, dynamic> json) => InOut(
    id: json['id'] as int,
    date: DateTime.parse(json['date'] as String),
    subRef: json['subRef'] as int,
    subName: json['Category'] != null ? json['Category']['name'] : '',
    DocID: json['docID'] ?? 0,
    type: json['type'] as bool,
    amount: (json['amount'] as num).toDouble(),
    RecPayAmount: (json['recPayAmount'] ?? 0).toDouble(),
    customerRef: json['customerRef'] as int,
    customerName: json['Customer'] != null ? json['Customer']['name'] : '',
    visitorRef: json['visitorRef'] ?? 0,
    currencyRef: json['currencyRef'] ?? defCrrency.id,
    currencyRatioM: (json['currencyRatioM'] ?? 1.0).toDouble(),
    currencyRatioD: (json['currencyRatioD'] ?? 1.0).toDouble(),
    description: json['description'] ?? '',
  );

  Map<String, dynamic> _$InOutToJson(InOut instance) => <String, dynamic>{
    'visitorRef': instance.visitorRef,
    'customerRef': instance.customerRef,
    'date': instance.date.toIso8601String(),
    'type': instance.type,
    'description': instance.description,
    'amount': instance.amount,
    'id': instance.id,
    'subRef': instance.subRef,
  };

  @override
  List<Object> get props => [
    id,
    date,
    currencyRef,
    currencyRatioM,
    currencyRatioD,
    description,
  ];
}

/////////////////////////////////////////////////////
