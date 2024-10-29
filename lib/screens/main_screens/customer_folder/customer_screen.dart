import 'package:flutter/material.dart';
import 'package:findik_muhasebe/screens/main_screens/customer_folder/add_customer_screen.dart';
import 'package:findik_muhasebe/screens/main_screens/customer_folder/customer_list_screen.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Müşteri Ekranı'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Müşteri ekleme ekranına git
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddCustomerScreen(), // Müşteri ekleme ekranını aç
                ),
              );
            },
          ),
        ],
      ),
      body: const CustomerListScreen(), // Müşteri listeleme ekranı
    );
  }
}
