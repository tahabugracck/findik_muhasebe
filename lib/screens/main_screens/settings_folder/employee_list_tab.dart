import 'package:findik_muhasebe/models/user.dart';
import 'package:findik_muhasebe/services/mongodb.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EmployeeListTab extends StatefulWidget {
  const EmployeeListTab({super.key});

  @override
  _EmployeeListTabState createState() => _EmployeeListTabState();
}

class _EmployeeListTabState extends State<EmployeeListTab> {
  List<UserModel> _employees = [];
  String? _errorMessage;
  bool _isLoading = true; // Veri yüklenme durumu

  @override
  void initState() {
    super.initState();
    _fetchEmployees(); // Çalışan verilerini getir
  }

  Future<void> _fetchEmployees() async {
    setState(() {
      _isLoading = true; // Veri yükleniyor durumu
    });
    try {
      final employeesList = await MongoDatabase.fetchEmployee(); // Veritabanından çalışanları al

      // Dönüştürme işlemi
      final List<UserModel> employees = employeesList.map((employeeData) {
        return UserModel.fromJson(employeeData); // JSON verisinden UserModel'e dönüştür
      }).toList();

      setState(() {
        _employees = employees; // Dönüştürülmüş listeyi ata
        _errorMessage = null; // Başarılı olursa hata mesajını sıfırla
        _isLoading = false; // Veri yüklenmesi bitti
      });

      if (kDebugMode) {
        print('Çalışan Verileri:');
        for (var employee in _employees) {
          print(employee.name); // Çalışanın adını yazdır
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Çalışan verileri alınırken hata oluştu: $e';
        _isLoading = false; // Veri yüklenmesi bitti
      });
      if (kDebugMode) {
        print(_errorMessage);
      }
    }
  }

  Future<void> _deleteEmployee(UserModel employee) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Çalışanı Sil'),
        content: Text('${employee.name} adlı çalışanı silmek istediğinize emin misiniz?'),
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

    if (confirmed == true) {
      try {
        await MongoDatabase.deleteEmployee(employee.id); // MongoDatabase sınıfında silme işlemi
        _fetchEmployees(); // Silme işlemi sonrası çalışanları yeniden getir
      } catch (e) {
        setState(() {
          _errorMessage = 'Çalışan silinirken hata oluştu: $e';
        });
      }
    }
  }

  void _goToEmployeeDetail(UserModel employee) {
    // Çalışan detaylarına gitme işlemi
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmployeeDetailPage(employee: employee),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Veriler yüklenirken gösterilir
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!)) // Eğer hata varsa mesajı göster
              : _employees.isEmpty
                  ? const Center(child: Text('Çalışan bulunamadı.')) // Boş liste durumu
                  : ListView.builder(
                      itemCount: _employees.length, // Çalışan sayısı kadar liste elemanı
                      itemBuilder: (context, index) {
                        final employee = _employees[index];
                        final name = employee.name; // UserModel içindeki name
                        final username = employee.username; // UserModel içindeki username
                        final accessRights = employee.accessRights.keys
                            .where((key) => employee.accessRights[key] == true)
                            .join(', '); // Erişebildiği ekranlar
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Kullanıcı Adı: $username'),
                                Text('Erişebildiği Ekranlar: $accessRights'),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _deleteEmployee(employee), // Çalışanı sil
                                ),
                                const Icon(Icons.arrow_forward),
                              ],
                            ),
                            onTap: () {
                              _goToEmployeeDetail(employee); // Detay sayfasına git
                            },
                          ),
                        );
                      },
                    ),
    );
  }
}

class EmployeeDetailPage extends StatelessWidget {
  final UserModel employee;
  const EmployeeDetailPage({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Adı: ${employee.name}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('Kullanıcı Adı: ${employee.username}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: employee.accessRights.keys
                  .where((key) => employee.accessRights[key] == true)
                  .map((key) => Chip(label: Text(key)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
