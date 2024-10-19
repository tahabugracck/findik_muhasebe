// ignore_for_file: unused_element

import 'dart:convert';

import 'package:crypto/crypto.dart';
//mport 'package:findik_muhasebe/services/mongodb.dart';
//import 'package:flutter/foundation.dart';

class PasswordCrypto {


/*
  // Kullaıcı girişi
  Future<bool> login(String username, String password) async {
    final hashedPassword = _hashPassword(password);

    try {
      final user = await MongoDatabase.fetchUserByUsername(username);
      if (user != null && user['password'] == hashedPassword) {
        return true;
      }
    } catch (e) {
      if (kDebugMode){
        print('Kullanıcı girişi sırasında hata oluştu: $e');
      }
    }
  }


*/

  // Şifreyi hash'leme
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}