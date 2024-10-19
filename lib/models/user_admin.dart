import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

UserAdminModel userAdminModelFromJson(String str) => UserAdminModel.fromJson(json.decode(str));

String userAdminModelToJson(UserAdminModel data) => json.encode(data.toJson());

class UserAdminModel {
  ObjectId id;
  String name;
  String password;
  bool admin;
  String username;

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
