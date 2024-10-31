import 'package:mongo_dart/mongo_dart.dart';

class DepositModel {
  final ObjectId id;
  final ObjectId customerId;
  final String itemName;
  final double quantity;
  final DateTime transactionDate;
  final bool status;
  final String description;

  DepositModel({
    required this.id,
    required this.customerId,
    required this.itemName,
    required this.quantity,
    required this.transactionDate,
    required this.status,
    required this.description,
  });

    factory DepositModel.fromJson(Map<String, dynamic> json) => DepositModel(
        id: json['_id'],
        customerId: json['customerId'],
        itemName: json['itemName'],
        quantity: json['quantity'],
        transactionDate: json['transactionDate'],
        status: json['status'],
        description: json['description'],
      );
Map<String, dynamic> toJson() => {
        '_id': id,
        'customerId': customerId,
        'itemName': itemName,
        'quantity': quantity,
        'transactionDate': transactionDate,
        'status': status,
        'description': description,
      };
    
 // copyWith metodu
  DepositModel copyWith({
    ObjectId? id,
    ObjectId? customerId,
    String? itemName,
    double? quantity,
    DateTime? transactionDate,
    bool? status,
    String? description,
  }) {
    return DepositModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      itemName: itemName ?? this.itemName,
      quantity: quantity ?? this.quantity,
      transactionDate: transactionDate ?? this.transactionDate,
      status: status ?? this.status,
      description: description ?? this.description,
    );
  }

}