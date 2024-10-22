import 'package:mongo_dart/mongo_dart.dart';

class UserAdminModel {
  final ObjectId id;
  final String name;
  final String password;
  final bool admin;
  final String username;

  UserAdminModel({
    required this.id,
    required this.name,
    required this.password,
    required this.admin,
    required this.username,
  });

  factory UserAdminModel.fromJson(Map<String, dynamic> json) => UserAdminModel(
      id: json['_id'],
      name: json['name'],
      password: json['password'],
      admin: json['admin'],
      username: json['username'],
    );
  

  Map<String, dynamic> toJson() => {

      '_id': id,
      'name': name,
      'password': password,
      'admin': admin,
      'username': username,

  };
}
