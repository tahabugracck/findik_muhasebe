import 'package:mongo_dart/mongo_dart.dart';

class UserAdminModel {
  final ObjectId id;
  final String name;
  final String password;
  final bool admin;
  final String username;
  final Map<String, bool> accessRights;
  List<Card> card;
  List<Cash> cash;

  UserAdminModel({
    required this.id,
    required this.name,
    required this.password,
    required this.admin,
    required this.username,
    required this.accessRights,
    required this.card,
    required this.cash,
  });

  factory UserAdminModel.fromJson(Map<String, dynamic> json) => UserAdminModel(
        id: json['_id'],
        name: json['name'],
        password: json['password'],
        admin: json['admin'],
        username: json['username'],
        accessRights: Map<String, bool>.from(json['accessRights'] as Map),
        card: List<Card>.from(json["card"].map((x) => Card.fromJson(x))),
        cash: List<Cash>.from(json["cash"].map((x) => Cash.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'password': password,
        'admin': admin,
        'username': username,
        'accessRights': accessRights,
        "card": List<dynamic>.from(card.map((x) => x.toJson())),
        "cash": List<dynamic>.from(cash.map((x) => x.toJson())),
      };
}

class Card {
  final String toFrom;
  final bool incoming;
  final double amount; // Düz bir int olarak
  final DateTime transactionDate; // DateTime olarak
  final String description;
  final ObjectId id;

  Card({
    required this.toFrom,
    required this.incoming,
    required this.amount,
    required this.transactionDate,
    required this.description,
    required this.id,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        toFrom: json['to_from'],
        incoming: json['incoming'],
        amount: json['amount'], // Düz bir int olarak
        transactionDate: json['transactionDate'], // Tarih formatını düzelt
        description: json['description'],
        id: json['_id'],
      );

  Map<String, dynamic> toJson() => {
        'to_from': toFrom,
        'incoming': incoming,
        'amount': amount, // Düz bir int olarak
        'transactionDate':
            transactionDate.toIso8601String(), // Tarih formatını düzelt
        'description': description,
        '_id': id,
      };
}

class Cash {
  final String toFrom;
  final bool incoming;
  final double amount; // Düz bir int olarak
  final DateTime transactionDate; // DateTime olarak
  final String description;
  final ObjectId id;

  Cash({
    required this.toFrom,
    required this.incoming,
    required this.amount,
    required this.transactionDate,
    required this.description,
    required this.id,
  });

  factory Cash.fromJson(Map<String, dynamic> json) => Cash(
        toFrom: json['to_from'],
        incoming: json['incoming'],
        amount: json['amount'], // Düz bir int olarak
        transactionDate: json['transactionDate'], // Tarih formatını düzelt
        description: json['description'],
        id: json['_id'],
      );

  Map<String, dynamic> toJson() => {
        'to_from': toFrom,
        'incoming': incoming,
        'amount': amount, // Düz bir int olarak
        'transactionDate':
            transactionDate.toIso8601String(), // Tarih formatını düzelt
        'description': description,
        '_id': id,
      };
}
