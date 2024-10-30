// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:findik_muhasebe/models/current_movements.dart';
import 'package:findik_muhasebe/services/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static late Db db;
  static late DbCollection usersCollection;
  static late DbCollection customersCollection;
  static late DbCollection currentMovementsCollection;

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
    customersCollection = db.collection(CUSTOMERS_COLLECTION);
    currentMovementsCollection = db.collection(CURRENTMOVEMENTS_COLLECTION);
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
  static Future<Map<String, dynamic>?> fetchUserByUsername(
      String username) async {
    try {
      final user =
          await usersCollection.findOne(where.eq('username', username));
      return user;
    } catch (e) {
      _logger.severe('Kullanıcı aranırken hata oluştu: $e');
      if (kDebugMode) {
        print('Kullanıcı aranırken hata oluştu: $e');
      }
    }
    return null;
  }


  // Tüm müşterileri çekme fonksiyonu
  static Future<List<Map<String, dynamic>>> fetchAllCustomers() async {
    try {
      final customers = await customersCollection.find().toList();
      return customers;
    } catch (e) {
      _logger.severe('Müşterileri çekerken bir hata oluştu: $e');
      if (kDebugMode) {
        print('Müşterileri çekerken bir hata oluştu: $e');
      }
    }
    return [];
  }


// Sadece admin olmayan kullanıcıları çekme fonksiyonu
static Future<List<Map<String, dynamic>>> fetchEmployee() async {
  try {
    final employee = await usersCollection.find({'admin': false}).toList();
    return employee;
  } catch (e) {
    _logger.severe('Çalışanları çekerken bir hata oluştu: $e');
    if (kDebugMode) {
      print('Çalışanları çekerken bir hata oluştu: $e');
    }
  }
  return [];
}

// Çalışanı silme fonksiyonu
  static Future<void> deleteEmployee(ObjectId id) async {
    try {
      await usersCollection.remove(where.id(id));
      if (kDebugMode) {
        _logger.info('Çalışan silindi: $id');
      }
    } catch (e) {
      _logger.severe('Çalışan silinirken hata oluştu: $e');
      if (kDebugMode) {
        print('Çalışan silinirken hata oluştu: $e');
      }
    }
  }

// Çalışan ekleme fonksiyonu
static Future<void> addEmployee(Map<String, dynamic> employeeData) async {
  try {
    await usersCollection.insert(employeeData);
    if (kDebugMode) {
      _logger.info('Çalışan eklendi: $employeeData');
    }
  } catch (e) {
    _logger.severe('Çalışan eklenirken hata oluştu: $e');
    if (kDebugMode) {
      print('Çalışan eklenirken hata oluştu: $e');
    }
  }
}

// Cari hareketleri çekmek için fonksiyon
// Cari hareketleri çekmek için fonksiyon
static Future<List<CurrentMovementsModel>> fetchCurrentMovements() async {
  try {
    final current = await currentMovementsCollection.find().toList();

    // Konsola yazdırma
    print('Cari Hareketler:');
    for (var item in current) {
      print(item);
    }

    return current.map((json) => CurrentMovementsModel.fromJson(json)).toList();
  } catch (e) {
    _logger.severe('Hareketleri çekerken hata oluştu: $e');
    if (kDebugMode) {
      print('Hareketleri çekerken hata oluştu: $e');
    }
  } 
  return [];
}









































































/*
 // Kart hareketini eklemek için metod
  static Future<void> addCardMovement(
      String userId, Map<String, dynamic> data) async {
    try {
      var collection = db.collection('users'); // users koleksiyonuna erişim
      var result = await collection.updateOne(
        where.eq(
            '_id',
            ObjectId.fromHexString(
                userId)), // Kullanıcı kimliğine göre kullanıcı bulunuyor.
        modify.push('card', {
          // 'card' alt objesine veri push ediliyor
          'to_from': data['to_from'], // Gönderen/Alıcı bilgisi
          'amount': data['amount'], // İşlem tutarı
          'transactionDate': DateTime.parse(data[
              'transactionDate']), // Tarih bilgisi doğru formatta gönderiliyor
          'description': data['description'], // İşlem açıklaması
          '_id': ObjectId(), // Her işlem için benzersiz bir ObjectId ekleniyor.
          'incoming': data['incoming'], // Gelir/gider olduğunu belirtiyor
        }),
      );

      if (result.isSuccess) {
        if (kDebugMode) {
          print('Kart hareketi başarıyla eklendi: $data');
        }
      } else {
        if (kDebugMode) {
          print('Kart hareketi eklenemedi: ${result.writeError}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Veritabanına eklerken hata: $e');
      }
    }
  }

// Nakit hareketini eklemek için metod
  static Future<void> addCashMovement(
      String userId, Map<String, dynamic> movement) async {
    try {
      var collection = db.collection('users'); // 'users' koleksiyonuna erişim
      var result = await collection.updateOne(
        where.eq(
            '_id',
            ObjectId.fromHexString(
                userId)), // Kullanıcı kimliğine göre kullanıcı bulunuyor.
        modify.push('cash', {
          // 'cash' alt objesine veri push ediliyor
          'to_from': movement['to_from'], // Gönderen/Alıcı bilgisi
          'amount': movement['amount'], // İşlem tutarı
          'transactionDate': DateTime.parse(movement['transactionDate'])
              .toIso8601String(), // Tarih bilgisi
          'description': movement['description'], // İşlem açıklaması
          '_id': ObjectId()
              // ignore: deprecated_member_use
              .toHexString(), // Her işlem için benzersiz bir ObjectId ekleniyor
          'incoming': movement['incoming'], // Gelir/gider olduğunu belirtiyor
        }),
      );

      if (result.isSuccess) {
        _logger.info(
            'Nakit hareketi başarıyla eklendi: $movement'); // Başarı mesajı loglanıyor.
      } else {
        _logger.severe(
            'Nakit hareketi eklenemedi: ${result.writeError}'); // Başarısızlık durumu loglanıyor.
      }
    } catch (e) {
      // Hata durumunda
      _logger.severe(
          'Nakit hareketi eklenirken hata oluştu: $e'); // Hata mesajı loglanıyor.
    }
  }

// Kart gelir hareketlerini çeken metod
  static Future<List<Map<String, dynamic>>> getCardsIncomeMovements() async {
    try {
      final movements =
          await usersCollection.find({'card.incoming': true}).toList();

      return movements
          .expand((user) => user['card'] as List<dynamic>)
          .where((card) => card['incoming'] == true)
          .map((card) {
        return {
          "description": card["description"] ?? "Açıklama Yok",
          "date": card["transactionDate"] ?? "Tarih Yok",
          "amount": card["amount"]?.toString() ?? "0",
          "to_from":
              card["to_from"] ?? "Gönderen Bilgisi Yok", // Gönderen bilgisi
        };
      }).toList();
    } catch (e) {
      _logger.severe('Kart gelir hareketlerini çekerken hata oluştu: $e');
      return [];
    }
  }

// Kart gider hareketlerini çeken metod
  static Future<List<Map<String, dynamic>>> getCardsExpenseMovements() async {
    try {
      final movements =
          await usersCollection.find({'card.incoming': false}).toList();

      return movements
          .expand((user) => user['card'] as List<dynamic>)
          .where((card) => card['incoming'] == false)
          .map((card) {
        return {
          "description": card["description"] ?? "Açıklama Yok",
          "date": card["transactionDate"] ?? "Tarih Yok",
          "amount": card["amount"]?.toString() ?? "0",
          "to_from":
              card["to_from"] ?? "Gönderen Bilgisi Yok", // Gönderen bilgisi
        };
      }).toList();
    } catch (e) {
      _logger.severe('Kart gider hareketlerini çekerken hata oluştu: $e');
      return [];
    }
  }

// Nakit gelir hareketlerini çeken metod
  static Future<List<Map<String, dynamic>>> getCashIncomeMovements() async {
    try {
      final movements =
          await usersCollection.find({'cash.incoming': true}).toList();

      return movements
          .expand((user) => user['cash'] as List<dynamic>)
          .where((cash) => cash['incoming'] == true)
          .map((cash) {
        return {
          "description": cash["description"] ?? "Açıklama Yok",
          "date": cash["transactionDate"] ?? "Tarih Yok",
          "amount": cash["amount"]?.toString() ?? "0",
          "to_from":
              cash["to_from"] ?? "Gönderen Bilgisi Yok", // Gönderen bilgisi
        };
      }).toList();
    } catch (e) {
      _logger.severe('Nakit gelir hareketlerini çekerken hata oluştu: $e');
      return [];
    }
  }

// Nakit gider hareketlerini çeken metod
  static Future<List<Map<String, dynamic>>> getCashExpenseMovements() async {
    try {
      final movements =
          await usersCollection.find({'cash.incoming': false}).toList();

      return movements
          .expand((user) => user['cash'] as List<dynamic>)
          .where((cash) => cash['incoming'] == false)
          .map((cash) {
        return {
          "description": cash["description"] ?? "Açıklama Yok",
          "date": cash["transactionDate"] ?? "Tarih Yok",
          "amount": cash["amount"]?.toString() ?? "0",
          "to_from":
              cash["to_from"] ?? "Gönderen Bilgisi Yok", // Gönderen bilgisi
        };
      }).toList();
    } catch (e) {
      _logger.severe('Nakit gider hareketlerini çekerken hata oluştu: $e');
      return [];
    }
  }
*/


}
