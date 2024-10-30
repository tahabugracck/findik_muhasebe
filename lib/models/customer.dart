import 'package:mongo_dart/mongo_dart.dart';

class CustomerModel {
  final ObjectId id; 
  final String name; 
  final double hazelnutAmount; 
  final String phoneNumber; 
  final List<ObjectId> userIds; 

  CustomerModel({
    required this.id,
    required this.name,
    required this.hazelnutAmount,
    required this.phoneNumber,
    required this.userIds, 
  });

  // JSON'dan Customer modeline dönüştürme
  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
    
      id: json['_id'], 
      name: json['name'], 
      hazelnutAmount: json['hazelnut_amount'], 
      phoneNumber: json['phone_number'] as String, 
      userIds: (json['userIds'] as List<dynamic>) 
          .map((e) => e as ObjectId)
          .toList(),

  );

  // Customer modelini JSON formatına dönüştürme
  Map<String, dynamic> toJson() => {
      '_id': id,
      'name': name,
      'hazelnut_amount': hazelnutAmount, 
      'phone_number': phoneNumber, 
      'userIds': userIds.map((e) => e).toList(), 
  };
}
