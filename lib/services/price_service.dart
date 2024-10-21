// price_service.dart
// ignore_for_file: unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class PriceService {
  // Fındık fiyatını çeken fonksiyon
  Future<double?> fetchPrice() async {
    final url = Uri.parse("https://borsa.tobb.org.tr/fiyat_urun3.php?ana_kod=9&alt_kod=904");
    
    try {
      var res = await http.get(url);
      if (res.statusCode == 200) {
        final document = parse(res.body);
        
        // "Ortalama" başlığına sahip hücreyi içeren satırı seç
        var rows = document.querySelectorAll('table#table0 tr');

        for (var row in rows) {
          var cells = row.querySelectorAll('td');
          
          // Eğer hücre sayısı uygun ise ve ortalama fiyat başlığı var ise
          if (cells.length >= 5) {
            var borsaAdi = cells[0]?.text.trim(); // Borsa adını al
            var ortalamaFiyat = cells[4]?.text.trim(); // Ortalama fiyat hücresini al

            // Eğer fiyat boş ya da null ise hata mesajı döndür
            if (ortalamaFiyat == null || ortalamaFiyat.isEmpty) {
              throw Exception('Ortalama fiyat bulunamadı');
            }

            return double.tryParse(ortalamaFiyat.replaceAll(',', '.'));
          }
        }
      } else {
        throw Exception('HTTP hata kodu: ${res.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Fiyat alınamadı: $e');
      } // Hata mesajı
      return null; // Hata durumunda null döner
    }

    return null; // Fiyat bulunamazsa null döner
  }
}
