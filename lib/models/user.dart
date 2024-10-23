import 'package:mongo_dart/mongo_dart.dart';

class UserModel {
  final ObjectId id;
  final String name;
  final String password;
  final bool admin;
  final String username;
  final Map<String, bool> accessRights;

  UserModel({
    required this.id,
    required this.name,
    required this.password,
    required this.admin,
    required this.username,
    required this.accessRights,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['_id'],
        name: json['name'],
        password: json['password'],
        admin: json['admin'],
        username: json['username'],
        accessRights: Map<String, bool>.from(json['accessRights'] as Map),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'password': password,
        'admin': admin,
        'username': username,
        'accessRights': accessRights,
      };
}
