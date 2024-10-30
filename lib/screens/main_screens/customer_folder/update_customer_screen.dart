// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:findik_muhasebe/models/customer.dart';
import 'package:findik_muhasebe/services/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' show where; // MongoDB'den gerekli sınıfları içe aktar

class UpdateCustomerScreen extends StatefulWidget {
  final CustomerModel customer; // Güncellenecek müşteri nesnesi

  const UpdateCustomerScreen({super.key, required this.customer});

  @override
  _UpdateCustomerScreenState createState() => _UpdateCustomerScreenState();
}

class _UpdateCustomerScreenState extends State<UpdateCustomerScreen> {
  final _formKey = GlobalKey<FormState>(); // Formun anahtarı

  late String _name; // Güncellenen müşteri ismi
  late double _hazelnutAmount; // Değiştirildi: double olarak güncellendi
  late String _phoneNumber; // Güncellenen telefon numarası

  @override
  void initState() {
    super.initState();
    // Mevcut müşteri bilgilerini form alanlarına yükle
    _name = widget.customer.name;
    _hazelnutAmount = widget.customer.hazelnutAmount;
    _phoneNumber = widget.customer.phoneNumber;
  }

  // Müşteri güncelleme fonksiyonu
  Future<void> _updateCustomer() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Form verilerini kaydet

      // Güncellenmiş müşteri nesnesi oluştur
      CustomerModel updatedCustomer = CustomerModel(
        id: widget.customer.id,
        name: _name,
        hazelnutAmount: _hazelnutAmount,
        phoneNumber: _phoneNumber,
        userIds: widget.customer.userIds, // Kullanıcı IDs'lerini koru
      );

      // Müşteriyi güncelle
      await MongoDatabase.customersCollection.update(
        where.eq('_id', widget.customer.id), 
        updatedCustomer.toJson(), 
      );

      // Başarılı güncelleme sonrası bilgi mesajı
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Müşteri başarıyla güncellendi!')),
      );

      Navigator.pop(context); // Ekranı kapat
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Müşteri Güncelle')), // Uygulama çubuğunda başlık
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding ile alan ekleyerek formu düzenli göster
        child: Form(
          key: _formKey, // Form anahtarı
          child: Column(
            children: [
              // İsim girişi için TextFormField
              TextFormField(
                decoration: const InputDecoration(labelText: 'İsim'), // Label tanımı
                initialValue: _name, // Mevcut ismi göster
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen bir isim girin'; // Hata mesajı
                  }
                  return null; // Geçerli değer
                },
                onSaved: (value) => _name = value!, // Değeri al
              ),
              
              // Fındık miktarı girişi için TextFormField
              TextFormField(
                decoration: const InputDecoration(labelText: 'Fındık Miktarı'), // Label tanımı
                keyboardType: const TextInputType.numberWithOptions(decimal: true), // On sayı girişi için klavye
                initialValue: _hazelnutAmount.toString(), // Mevcut fındık miktarını göster
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
                initialValue: _phoneNumber, // Mevcut telefon numarasını göster
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Lütfen bir telefon numarası girin'; // Hata mesajı
                  }
                  return null; // Geçerli değer
                },
                onSaved: (value) => _phoneNumber = value!, // Değeri al
              ),
              
              const SizedBox(height: 20), // Alanlar arası boşluk
              
              // Müşteri güncelleme butonu
              ElevatedButton(
                onPressed: _updateCustomer, // Butona basıldığında müşteri güncelle
                child: const Text('Güncelle'), // Buton metni
              ),
            ],
          ),
        ),
      ),
    );
  }
}
