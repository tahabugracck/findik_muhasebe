import 'package:mongo_dart/mongo_dart.dart';

class CurrentMovementsModel {
  final ObjectId id;
 final ObjectId customerId; // İşlemin hangi müşteriye ait olduğunu belirtir.
 final String transactionType; // İşlem türünü belirtiyor
 final DateTime transactionDate; // İşlemin gerçekleştiği tarih
 final double amount; //  İşlem tutarı
 final String description; // Açıklama
 final double balanceAfterTransaction; // İşlem sonrasında müşterinin hesabındaki toplam bakiye miktarını belirtir
 final DateTime createdAt; // Belgenin oluşturma tarihi
 final ObjectId createdId; // İşlemi yapan kullanıcı (users koleksiyonundaki kullanıcılar)

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
        transactionDate: json['transactionDate'],
        amount: json['amount'],
        description: json['description'],
        balanceAfterTransaction: json['balanceAfterTransaction'],
        createdAt: json['createdAt'],
        createdId: json['createdId'],
      );

  get title => null;

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
