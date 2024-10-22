// ignore_for_file: prefer_typing_uninitialized_variables


import 'package:findik_muhasebe/services/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static late Db db;
  static late DbCollection usersCollection;

  static final Logger _logger = Logger('MongoDatabase');

  // MongoDB bağlantısını başlatma
  static Future<void> connect() async {
    try {
      db = await Db.create(MONGO_CONN_URL);
      await db.open();
      _initializeCollections();

      if (kDebugMode) {
      _logger.info('MongoDB bağlantısı başarılı');
      print("MongoDB bağlantısı başarılı");
      }
    } catch (e) {
      _logger.severe('MongoDB bağlantısı başarısız: $e');
      if (kDebugMode) {
        print('MongoDB bağlantısı başarısız: $e');
      }
    }
  }

  // Koleksiyonları başlatma
  static void _initializeCollections() {
    usersCollection = db.collection(USERS_COLLECTION);
  }

  // MongoDB bağlantısını kapatma
  static Future<void> close() async {
    try {
      await db.close();
      if (kDebugMode) {
        _logger.info("MongoDB bağlantısı kapatıldı");
      }
    } catch (e) {
      _logger.severe("MongoDB bağlantısını kapatırken hata oluştu: $e");
    }
  }

  // Kullanıcı adı ile kullanıcıyı veritabanında arayan metod
  static Future<Map<String, dynamic>?> fetchUserByUsername(String username) async {
    try {
        final user = await usersCollection.findOne(where.eq('username', username));
        return user;
    } catch (e) {
        _logger.severe('Kullanıcı aranırken hata oluştu: $e');
        if (kDebugMode) {
            print('Kullanıcı aranırken hata oluştu: $e');
        }
    }
    return null;
}


}