// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:findik_muhasebe/models/current_movements.dart';
import 'package:findik_muhasebe/models/deposit.dart';
import 'package:findik_muhasebe/models/payments.dart';
import 'package:findik_muhasebe/models/product_operations.dart';
import 'package:findik_muhasebe/services/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static late Db db;
  static late DbCollection usersCollection;
  static late DbCollection customersCollection;
  static late DbCollection currentMovementsCollection;
  static late DbCollection paymentsCollection;
  static late DbCollection depositCollection;
  static late DbCollection productOperations;

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
    paymentsCollection = db.collection(PAYMENTS_COLLECTION);
    depositCollection = db.collection(DEPOSIT_COLLECTION);
    productOperations = db.collection(PRODUCTOPERATIONS_COLLECTION);
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
static Future<List<CurrentMovementsModel>> fetchCurrentMovements() async {
  try {
    final current = await currentMovementsCollection.find().toList();

    return current.map((json) => CurrentMovementsModel.fromJson(json)).toList();
  } catch (e) {
    _logger.severe('Hareketleri çekerken hata oluştu: $e');
    if (kDebugMode) {
      print('Hareketleri çekerken hata oluştu: $e');
    }
  } 
  return [];
}

// Cari hareket eklemek için fonksiyon
static Future<bool> addCurrentMovement(CurrentMovementsModel movement) async {
  try {
    await currentMovementsCollection.insertOne(movement.toJson());
    return true;
  } catch (e) {
    _logger.severe('Cari hareket eklerken hata oluştu: $e');
    if (kDebugMode) {
      print('Cari hareket eklerken hata oluştu: $e');
    }
    return false;
  }
}


// Cari hareket güncellemek için fonksiyon
static Future<bool> updateCurrentMovement(ObjectId id, CurrentMovementsModel movement) async {
  try {
    final result = await currentMovementsCollection.updateOne(
      where.id(id),
      modify.set('customerId', movement.customerId)
            .set('transactionType', movement.transactionType)
            .set('transactionDate', movement.transactionDate)
            .set('amount', movement.amount)
            .set('description', movement.description)
            .set('balanceAfterTransaction', movement.balanceAfterTransaction)
            .set('createdAt', movement.createdAt)
            .set('createdId', movement.createdId),
    );
    return result.isSuccess;
  } catch (e) {
    _logger.severe('Cari hareket güncellerken hata oluştu: $e');
    if (kDebugMode) {
      print('Cari hareket güncellerken hata oluştu: $e');
    }
    return false;
  }
}


// Cari hareket silmek için fonksiyon
static Future<bool> deleteCurrentMovement(ObjectId id) async {
  try {
    final result = await currentMovementsCollection.deleteOne(where.id(id));
    return result.isSuccess;
  } catch (e) {
    _logger.severe('Cari hareket silerken hata oluştu: $e');
    if (kDebugMode) {
      print('Cari hareket silerken hata oluştu: $e');
    }
    return false;
  }
}













// Tahsilat hareketleri çekmek için fonksiyon
static Future<List<PaymentsModel>> fetchPaymentsMovements() async {
  try {
    final payments = await paymentsCollection.find().toList();

    return payments.map((json) => PaymentsModel.fromJson(json)).toList();
  } catch (e) {
    _logger.severe('Hareketleri çekerken hata oluştu: $e');
    if (kDebugMode) {
      print('Hareketleri çekerken hata oluştu: $e');
    }
  } 
  return [];
}

//  Tahsilat hareketleri eklemek için fonksiyon
static Future<bool> addPaymentMovement(PaymentsModel payment) async {
  try {
    await paymentsCollection.insertOne(payment.toJson());
    return true;
  } catch (e) {
    _logger.severe('Tahsilat hareketi eklerken hata oluştu: $e');
    if (kDebugMode) {
      print('Tahsilat hareketi eklerken hata oluştu: $e');
    }
    return false;
  }
}


// Tahsilat hareketleri güncellemek için fonksiyon
static Future<bool> updatePaymentMovement(ObjectId id, PaymentsModel payment) async {
  try {
    final result = await paymentsCollection.updateOne(
      where.id(id),
      modify.set('customerId', payment.customerId)
            .set('createdBy', payment.createdBy)
            .set('collectionDate', payment.collectionDate)
            .set('amount', payment.amount)
            .set('method', payment.method)
            .set('description', payment.description)
            .set('createdAt', payment.createdAt),
    );
    return result.isSuccess;
  } catch (e) {
    _logger.severe('Tahsilat hareketi güncellerken hata oluştu: $e');
    if (kDebugMode) {
      print('Tahsilat hareketi güncellerken hata oluştu: $e');
    }
    return false;
  }
}


// Tahsilat hareketi silmek için fonksiyon
static Future<bool> deletePaymentMovement(ObjectId id) async {
  try {
    final result = await paymentsCollection.deleteOne(where.id(id));
    return result.isSuccess;
  } catch (e) {
    _logger.severe('Tahsilat hareketi silerken hata oluştu: $e');
    if (kDebugMode) {
      print('Tahsilat hareketi silerken hata oluştu: $e');
    }
    return false;
  }
}




// Emanetleri veri tabanından çeken fonksiyon
static Future<List<Map<String, dynamic>>> fetchAllDeposit() async {
  try {
    final deposit = await depositCollection.find().toList();
    return deposit;
  } catch (e) {
    _logger.severe('Emanetleri çekerken bir hata oluştu: $e');
    if (kDebugMode) {
      print('Emanetleri çekerken bir hata oluştu: $e');
    }
    return []; // eğer hata oluşursa boş liste döndür
  }
}

// Emanet ekleme fonksiyonu
static Future<void> addDeposit(DepositModel deposit) async {
  try {
    await depositCollection.insertOne(deposit.toJson());
  } catch (e) {
    // Hata durumunda gerekli işlemleri yapabilirsiniz
    throw Exception('Emanet eklenirken hata oluştu: $e');
  }
}

// Emanet silme fonksiyonu
static Future<void> deleteDeposit(ObjectId id) async {
  try {
    await depositCollection.deleteOne(where.eq('_id', id));
  } catch (e) {
    // Hata durumunda gerekli işlemleri yapabilirsiniz
    throw Exception('Emanet silinirken hata oluştu: $e');
  }
}

// Emanet güncelleme fonksiyonu
static Future<void> updateDeposit(DepositModel deposit) async {
  try {
    await depositCollection.updateOne(
      where.eq('_id', deposit.id),
      modify.set('customerId', deposit.customerId)
            .set('itemName', deposit.itemName)
            .set('quantity', deposit.quantity)
            .set('transactionDate', deposit.transactionDate)
            .set('status', deposit.status)
            .set('description', deposit.description),
    );
  } catch (e) {
    // Hata durumunda gerekli işlemleri yapabilirsiniz
    throw Exception('Emanet güncellenirken hata oluştu: $e');
  }
}

// Ürün işlemleri verilerini çekme fonksiyonu
static Future<List<Map<String, dynamic>>> fetchProductOperations() async {
  try {
    final product = await productOperations.find().toList();
    return product; 
  } catch (e) {
    _logger.severe('Ürün işlemlerini çekerken bir hata oluştu: $e');
    if (kDebugMode) {
      print('Ürün işlemlerini çekerken bir hata oluştu: $e');
    }
    return [];
  }
}

// Ürün satışı için fonksiyon
static Future<void> updateProductQuantity(ObjectId id, double newQuantity) async {
    var collection = db.collection('product_operations');
    await collection.updateOne(where.eq('_id', id), modify.set('quantity', newQuantity));
  }

// Ürün ekleme  fonksiyonu
static Future<void> addProductOperation(ProductOperationsModel productOperation) async {
  try {
    var collection = db.collection('product_operations');
    await collection.insertOne(productOperation.toJson());
  } catch (e) {
    _logger.severe('Ürün kaydederken hata oluştu: $e');
    if (kDebugMode) {
      print('Ürün kaydederken hata oluştu: $e');
    }
  }



































































}
// Nakit gelir hareketlerini çeken metod
  static Future<List<Map<String, dynamic>>> getCashIncomeMovements() async{
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
  static Future<List<Map<String, dynamic>>> getCashExpenseMovements() async{
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


// Kart gider hareketlerini çeken metod
  static Future<List<Map<String,dynamic>>> getCardsExpenseMovements() async{
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

// Kart gelir hareketlerini çeken metod
  static Future<List<Map<String,dynamic>>> getCardsIncomeMovements() async{
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


// Nakit hareketini eklemek için metod
  static Future<void> addCardMovement(
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

 // Kart hareketini eklemek için metod
  static Future<void> addCashMovement(
    
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
}