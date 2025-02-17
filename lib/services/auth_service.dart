import 'package:findik_muhasebe/crypto/password_crypto.dart';
import 'package:findik_muhasebe/models/user_admin.dart';
import 'package:flutter/foundation.dart';
import 'package:mongo_dart/mongo_dart.dart';

class AuthService {
  final Db db = Db('');

  Future<UserAdminModel?> login(String username, String password) async {
    try {
      await db.open();
      var usersCollection = db.collection('users');

      // Kullanıcıyı veritabanında ara
      var userDocument = await usersCollection.findOne(where.eq('username', username));
      if (userDocument != null) {
        var user = UserAdminModel.fromJson(userDocument);

        // Şifreyi karşılaştır
        if (PasswordCrypto.verifyPassword(password, user.password)) {
          return user; // Giriş başarılı
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Giriş sırasında hata: $e');
      }
    } finally {
      await db.close();
    }
    return null; // Giriş başarısız
  }
}
