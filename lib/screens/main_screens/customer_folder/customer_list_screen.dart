// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:findik_muhasebe/models/customer.dart';
import 'package:findik_muhasebe/screens/main_screens/customer_folder/update_customer_screen.dart';
import 'package:findik_muhasebe/services/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' show ObjectId, where; // MongoDB'den gerekli sınıfları içe aktar

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  _CustomerListScreenState createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  late Future<List<CustomerModel>> _customers; // Müşterileri tutacak olan Future değişkeni

  @override
  void initState() {
    super.initState();
    _customers = fetchCustomers(); // Müşterileri çekmek için fonksiyonu çağır
  }

  // Veritabanından tüm müşterileri çeken fonksiyon
  Future<List<CustomerModel>> fetchCustomers() async {
    final customerData = await MongoDatabase.fetchAllCustomers();
    return customerData.map((customer) => CustomerModel.fromJson(customer)).toList(); // JSON'dan Customer modeline çevir
  }

  // Müşteriyi silme fonksiyonu
  Future<void> _deleteCustomer(ObjectId customerId) async {
    await MongoDatabase.customersCollection.remove(where.eq('_id', customerId)); // Müşteriyi veritabanından sil
    setState(() {
      _customers = fetchCustomers(); // Listeyi güncelle
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Müşteri silindi!')), // Bilgilendirme mesajı
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 // Uygulama çubuğunda başlık
      body: FutureBuilder<List<CustomerModel>>(
        future: _customers, // Beklenen müşteri listesini kullan
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Yükleniyor göstergesi
          } else if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu: ${snapshot.error}')); // Hata mesajı
          } else {
            final customers = snapshot.data!; // Müşteri verileri

            return ListView.builder(
              itemCount: customers.length, // Müşteri sayısı
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(customers[index].name), // Müşteri adı
                  subtitle: Text('Fındık Miktarı: ${customers[index].hazelnutAmount}'), // Müşteri fındık miktarı
                  trailing: IconButton(
                    icon: const Icon(Icons.delete), // Silme ikonu
                    onPressed: () async {
                      // Silme işlemi için onay iste
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Silmek İstediğinizden Emin Misiniz?'),
                          content: const Text('Bu işlemi geri alamazsınız.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Hayır'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Evet'),
                            ),
                          ],
                        ),
                      );

                      // Kullanıcı onay verirse sil
                      if (confirm == true) {
                        await _deleteCustomer(customers[index].id);
                      }
                    },
                  ),
                  onTap: () {
                    // Müşteri güncelleme ekranına yönlendirme
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateCustomerScreen(customer: customers[index]), // Güncelleme ekranını aç
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
