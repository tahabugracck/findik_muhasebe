// ignore_for_file: unused_element

import 'dart:convert';

import 'package:crypto/crypto.dart';


class PasswordCrypto {
  
  // Şifreyi hash'leme
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Şifreyi doğrulama
  static bool verifyPassword(String inputPassword, String hashedPassword) {
    final bytes = utf8.encode(inputPassword);
    final digest = sha256.convert(bytes);
    return digest.toString() == hashedPassword;
  }
}