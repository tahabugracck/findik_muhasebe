// price_update_screen.dart
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../services/price_service.dart'; // Fiyat servisini dahil et

class PriceUpdateScreen extends StatefulWidget {
  const PriceUpdateScreen({super.key});

  @override
  _PriceUpdateScreenState createState() => _PriceUpdateScreenState();
}

class _PriceUpdateScreenState extends State<PriceUpdateScreen> {
  double? currentPrice; // Mevcut fındık fiyatını tutacak değişken
  final PriceService _priceService = PriceService(); // Servis sınıfından bir nesne oluşturuyoruz
  bool isLoading = true; // Yüklenme durumu
  String errorMessage = ''; // Hata mesajı için değişken

  @override
  void initState() {
    super.initState();
    _fetchCurrentPrice(); // Ekran açıldığında fiyatı çek
  }

  // Fiyatı çekip güncelleyen fonksiyon
  Future<void> _fetchCurrentPrice() async {
    setState(() {
      isLoading = true; // Yüklenme işlemi başladı
      errorMessage = ''; // Önceki hata mesajını sıfırla
    });

    try {
      double? price = await _priceService.fetchPrice();
      setState(() {
        currentPrice = price;
        isLoading = false; // Yüklenme işlemi bitti

        // Hata kontrolü
        if (currentPrice == null) {
          errorMessage = 'Fiyat alınamadı. Lütfen tekrar deneyin.'; // Hata mesajı
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Yüklenme işlemi bitti
        errorMessage = 'Bir hata oluştu: $e'; // Daha ayrıntılı hata mesajı
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fiyat Güncelle'),
        backgroundColor: Colors.green, // Başlık rengini yeşil yap
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator()) // Yükleniyor göstergesi
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentPrice != null
                        ? 'Mevcut Fındık Fiyatı: ${currentPrice!.toStringAsFixed(2)} TL'
                        : errorMessage, // Hata mesajı göster
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _fetchCurrentPrice,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Buton rengi
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30), // Buton içi boşluk
                      textStyle: const TextStyle(fontSize: 18), // Buton yazı boyutu
                    ), // Fiyatı yeniden güncelle
                    child: const Text('Fiyatı Güncelle'),
                  ),
                  const SizedBox(height: 20),
                  if (errorMessage.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
