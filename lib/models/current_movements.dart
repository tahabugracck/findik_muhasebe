import 'package:mongo_dart/mongo_dart.dart';

class CurrentMovementsModel {
  ObjectId id;
  ObjectId customerId; // İşlemin hangi müşteriye ait olduğunu belirtir.
  String transactionType; // İşlem türünü belirtiyor
  DateTime transactionDate; // İşlemin gerçekleştiği tarih
  double amount; //  İşlem tutarı
  String description; // Açıklama
  double
      balanceAfterTransaction; // İşlem sonrasında müşterinin hesabındaki toplam bakiye miktarını belirtir
  DateTime createdAt; // Belgenin oluşturma tarihi
  ObjectId
      createdId; // İşlemi yapan kullanıcı (users koleksiyonundaki kullanıcılar)

  CurrentMovementsModel({
    required this.id,
    required this.customerId,
    required this.transactionType,
    required this.transactionDate,
    required this.amount,
    required this.description,
    required this.balanceAfterTransaction,
    required this.createdAt,
    required this.createdId,
  });
  factory CurrentMovementsModel.fromJson(Map<String, dynamic> json) =>
      CurrentMovementsModel(
        id: json['_id'],
        customerId: json['customerId'],
        transactionType: json['transactionType'],
        transactionDate: DateTime.parse(json['transactionDate']),
        amount: json['amount'],
        description: json['description'],
        balanceAfterTransaction: json['balanceAfterTransaction'],
        createdAt: DateTime.parse(json['createdAt']),
        createdId: json['createdId'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'customerId': customerId,
        'transactionType': transactionType,
        'transactionDate': transactionDate.toIso8601String(),
        'amount': amount,
        'description': description,
        'balanceAfterTransaction': balanceAfterTransaction,
        'createdAt': createdAt.toIso8601String(),
        'createdId': createdId,
      };
}
