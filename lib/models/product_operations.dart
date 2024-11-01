import 'package:mongo_dart/mongo_dart.dart';

class ProductOperationsModel {
  final ObjectId id;
  final String operationType;
  final double quantity; // fındık adet
  final double quality; // fındığın randumanı
  final DateTime createdAt;
  final ObjectId createdId;

  ProductOperationsModel({
    required this.id,
    required this.operationType,
    required this.quantity,
    required this.quality,
    required this.createdAt,
    required this.createdId,
  });

  factory ProductOperationsModel.fromJson(Map<String, dynamic> json) => ProductOperationsModel(
        id: json['_id'],
        operationType: json['operationType'],
        quantity: json['quantity'],
        quality: json['quality'],
        createdAt: json['createdAt'],
        createdId: json['createdId'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'operationType': operationType,
        'quantity': quantity,
        'quality': quality,
        'createdAt': createdAt,
        'createdId': createdId,
      };
}