import 'package:mongo_dart/mongo_dart.dart';

class PaymentsModel {
  ObjectId id;
  ObjectId customerId;
  ObjectId createdBy;
  DateTime collectionDate;
  double amount;
  String method;
  String description;
  DateTime createdAt;

  PaymentsModel({
    required this.id,
    required this.customerId,
    required this.createdBy,
    required this.collectionDate,
    required this.amount,
    required this.method,
    required this.description,
    required this.createdAt,
  });

  factory PaymentsModel.fromJson(Map<String, dynamic> json) => PaymentsModel(
        id: json["_id"],
        customerId: json["customerId"],
        createdBy: json["createdBy"],
        collectionDate: DateTime.parse(json["collectionDate"]),
        amount: json["amount"],
        method: json["method"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  get title => null;

  Map<String, dynamic> toJson() => {
        "_id": id,
        "customerId": customerId,
        "createdBy": createdBy,
        "collectionDate": collectionDate.toIso8601String,
        "amount": amount,
        "method": method,
        "description": description,
        "createdAt": createdAt.toIso8601String,
      };
}
