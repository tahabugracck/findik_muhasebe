// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:findik_muhasebe/models/customer.dart';
import 'package:findik_muhasebe/services/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' show ObjectId;

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  _AddCustomerScreenState createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  // Formun anahtarını tanımlıyoruz
  final _formKey = GlobalKey<FormState>();
  
  // Müşteri bilgileri için değişkenler
  late String _name;
  late double _hazelnutAmount; // Değiştirildi: double olarak güncellendi
  late String _phoneNumber;

  // Müşteri ekleme fonksiyonu
  Future<void> _addCustomer() async {
    // Form geçerliliğini kontrol et
    if (_formKey.currentState!.validate()) {
      // Form verilerini kaydet
      _formKey.currentState!.save();
      
      // Yeni müşteri nesnesi oluştur
      Customer newCustomer = Customer(
        id: ObjectId(), // MongoDB'den otomatik olarak ID alacağız
        name: _name,
        hazelnutAmount: _hazelnutAmount,
        phoneNumber: _phoneNumber,
        userIds: [], // User IDs eklenebilir
      );

      // Müşteriyi veritabanına ekle
      await MongoDatabase.customersCollection.insert(newCustomer.toJson());
      
      // Başarılı bir ekleme sonrası kullanıcıya bilgi ver
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Müşteri başarıyla eklendi!')),
      );
      
      // Form ekranını kapat
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Müşteri Ekle')), // Uygulama çubuğunda başlık
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding ile alan ekleyerek formu düzenli göster
        child: Form(
          key: _formKey, // Form anahtarı
          child: Column(
            children: [
              // İsim girişi için TextFormField
              TextFormField(
                decoration: const InputDecoration(labelText: 'İsim'), // Label tanımı
                validator: (value) {
                  // Geçerli bir değer olup olmadığını kontrol et
                  if (value!.isEmpty) {
                    return 'Lütfen bir isim girin'; // Hata mesajı
                  }
                  return null; // Geçerli değer
                },
                onSaved: (value) => _name = value!, // Form kaydedildiğinde değeri al
              ),
              
              // Fındık miktarı girişi için TextFormField
              TextFormField(
                decoration: const InputDecoration(labelText: 'Fındık Miktarı'), // Label tanımı
                keyboardType: TextInputType.numberWithOptions(decimal: true), // On sayı girişi için klavye
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen bir miktar girin'; // Hata mesajı
                  }
                  final number = double.tryParse(value);
                  if (number == null) {
                    return 'Lütfen geçerli bir sayı girin'; // Hata mesajı
                  }
                  return null; // Geçerli değer
                },
                onSaved: (value) => _hazelnutAmount = double.parse(value!), // Değeri al ve double'a çevir
              ),
              
              // Telefon numarası girişi için TextFormField
              TextFormField(
                decoration: const InputDecoration(labelText: 'Telefon Numarası'), // Label tanımı
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen bir telefon numarası girin'; // Hata mesajı
                  }
                  return null; // Geçerli değer
                },
                onSaved: (value) => _phoneNumber = value!, // Değeri al
              ),
              
              const SizedBox(height: 20), // Alanlar arası boşluk
              
              // Müşteri ekleme butonu
              ElevatedButton(
                onPressed: _addCustomer, // Butona basıldığında müşteri ekle
                child: const Text('Ekle'), // Buton metni
              ),
            ],
          ),
        ),
      ),
    );
  }
}
