// ignore_for_file: library_private_types_in_public_api

import 'package:findik_muhasebe/screens/main_screens/entrusted_screen.dart';
import 'package:findik_muhasebe/screens/main_screens/factory_operations_screen.dart';
import 'package:findik_muhasebe/screens/main_screens/login_screen.dart';
import 'package:findik_muhasebe/screens/main_screens/customer_screen.dart'; // Müşteri ekranı
import 'package:findik_muhasebe/screens/main_screens/sales_screen.dart';
import 'package:findik_muhasebe/screens/main_screens/stock_screen.dart'; // Stok ekranı
import 'package:findik_muhasebe/screens/main_screens/invoice_screen.dart'; // Fatura işlemleri ekranı
import 'package:findik_muhasebe/screens/main_screens/cash_screen.dart'; // Kasa işlemleri ekranı
import 'package:findik_muhasebe/screens/main_screens/settings_screen.dart'; // Ayarlar ekranı
import 'package:findik_muhasebe/screens/main_screens/price_update_screen.dart'; // Fiyat güncelle ekranı
import 'package:findik_muhasebe/screens/main_screens/account_movements_screen.dart'; // Cari hareketler ekranı
import 'package:findik_muhasebe/screens/main_screens/report_screen.dart'; // Rapor ekranı
import 'package:findik_muhasebe/screens/main_screens/preliminary_accounting_screen.dart'; // Ön muhasebe ekranı
import 'package:findik_muhasebe/screens/main_screens/product_entry_screen.dart'; // Ürün girişi ekranı
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final bool hasMobileScreen;
  final Function(Widget) onMenuItemSelected;

  const CustomDrawer({
    super.key,
    required this.hasMobileScreen,
    required this.onMenuItemSelected,
  });

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? selectedItem; // Seçili olan menü elemanını tutar
  bool isExpanded = false; // Menünün geniş olup olmadığını belirten değişken

  // Renkler
  final Color primaryColor = const Color(0xFF1E1E1E); // Gri tonlarında arka plan
  final Color secondaryColor = const Color(0xFF424242); // Daha açık gri ton

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isExpanded ? 230 : 70, // Genişlik butona tıklama durumuna göre değişir
      color: primaryColor,
      child: Column(
        children: [
          // Genişleme ve daralma butonu en üstte
          IconButton(
            icon: Icon(
              isExpanded ? Icons.arrow_circle_left : Icons.arrow_circle_right, // İkon değiştirildi
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded; // Butona basıldığında menü genişleyip daralır
              });
            },
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            color: primaryColor,
            alignment: Alignment.center,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isExpanded
                  ? const Text(
                      'Fındık Muhasebe',
                      key: ValueKey('Expanded'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Container(key: const ValueKey('Collapsed')),
            ),
          ),
          Divider(color: Colors.white.withOpacity(0.2)), // Üstteki çizgi

          // "Ekranlar" başlığı
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: isExpanded
                    ? const Text(
                        'Ekranlar', // Ekranlar başlığı
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Container(), // Genişlememiş durumda boş bırakılır
              ),
            ),
          ),

          // Menü listesi (ekranlar)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildListTile(Icons.person, 'Müşteri', const CustomerScreen()),
                  buildListTile(Icons.storage, 'Stok', const StockScreen()),
                  buildListTile(Icons.file_copy, 'Fatura İşlemleri', const InvoiceScreen()),
                  buildListTile(Icons.account_balance_wallet, 'Kasa İşlemleri', const CashScreen()),
                  buildListTile(Icons.settings, 'Ayarlar', const SettingsScreen()),
                  buildListTile(Icons.factory, 'Fabrika İşlemleri', const FactoryOperationsScreen()),
                  buildListTile(Icons.receipt, 'Emanet', const EntrustedScreen()),
                  buildListTile(Icons.price_change, 'Fiyat Güncelle', const PriceUpdateScreen()),
                  buildListTile(Icons.sell, 'Satış', const SalesScreen()),
                  buildListTile(Icons.account_balance, 'Cari Hareketler', const AccountMovementsScreen()),
                  buildListTile(Icons.assessment, 'Rapor', const ReportScreen()),
                  buildListTile(Icons.article, 'Ön Muhasebe', const PreliminaryAccountingScreen()),
                  buildListTile(Icons.add_box, 'Ürün Girişi', const ProductEntryScreen()),
                ],
              ),
            ),
          ),

          // Alt kısma ayarlar ve kullanıcı değiştirme
          Divider(color: Colors.white.withOpacity(0.2)), // Alttaki çizgi
          
          buildListTile(Icons.arrow_back_rounded, 'Ana Sayfa', Container(), () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }),
        ],
      ),
    );
  }

  // Menüyü oluşturan liste elemanları
  Widget buildListTile(IconData icon, String title, Widget page, [VoidCallback? onTapOverride]) {
    final isSelected = selectedItem == title; // Seçili olup olmadığını kontrol eder

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = title; // Seçilen öğeyi günceller
        });
        if (onTapOverride != null) {
          onTapOverride();
        } else {
          widget.onMenuItemSelected(page); // Sayfa geçişini sağlar
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isSelected ? secondaryColor : Colors.transparent, // Seçili olan menü elemanının rengini değiştirir
          borderRadius: BorderRadius.circular(50),
          boxShadow: isSelected
              ? [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8, spreadRadius: 1)] // Seçili olan menü elemanına gölge ekler
              : null,
        ),
        child: ListTile(
          leading: Icon(icon, color: isSelected ? Colors.black : Colors.white), // İkonun rengi seçili olup olmamasına göre değişir
          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: isExpanded
                ? Text(
                    title,
                    key: ValueKey(title),
                    style: TextStyle(color: isSelected ? Colors.black : Colors.white), // Başlık rengi
                  )
                : const SizedBox.shrink(), // Menü daraltılmışken başlık gösterilmez
          ),
        ),
      ),
    );
  }
}
