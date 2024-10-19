// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:findik_muhasebe/services/mongodb.dart';
import 'package:findik_muhasebe/widgets/loading_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  // TextEditingController'lar, kullanıcı adı ve şifreyi almak için kullanılır
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false; // Yükleniyor durumunu kontrol eder
  bool _isAnimated = false; // Animasyon durumunu kontrol eder
  bool _obscureText = true; // Şifre alanındaki metni gizlemek için kullanılır

  @override
  void initState() {
    super.initState();

    // Animasyonu başlatmak için delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimated = true;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Sol tarafta animasyonlu bir karşılama bölümü
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            width: _isAnimated ? MediaQuery.of(context).size.width / 2 : 0,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.3),
                  Colors.blue.withOpacity(0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                ),
            ),
            child: Center(
              child: AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: _isAnimated ? 1 : 0,
                child: const Text(
                  'Hoşgeldiniz',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ),

            // Sağ tarafta giriş formu
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Giriş yap başlığı
                        const Text(
                          'Giriş Yap',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Kullanıcı adı alanı
                        _buildTextField(
                            controller: _usernameController,
                            label: 'Kullanıcı Adı',
                            prefixIcon: Icons.person,
                            onSubmitted: (_) => _focusPasswordField(),
                          ),
                        const SizedBox(height: 20),
                         // Şifre girişi
                      _buildTextField(
                        controller: _passwordController,
                        label: 'Şifre',
                        prefixIcon: Icons.lock,
                        obscureText: _obscureText,
                        onSubmitted: (_) => _login(),
                      ),
                      const SizedBox(height: 30),
                      // Yükleniyor göstergesi veya giriş butonu
                      _isLoading
                        ? _buildLoadingIndicator()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: _buildGradientButton(
                                    onPressed: _login,
                                    text: 'Giriş Yap',
                                    colors: [
                                      Colors.blue,
                                      Colors.blue.withOpacity(0.7),
                                    ],
                                    textColor: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                      const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
    
    // Metin giriş alanı oluşturma fonksiyonu
   Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData prefixIcon,
    bool obscureText = false,
    void Function(String)? onSubmitted,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: label == 'Şifre' // Yalnızca şifre için göz ikonu
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText; // Şifre alanının görünürlüğünü değiştir
                  });
                },
              )
            : null, // Kullanıcı adı için ikon yok
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
              borderRadius: BorderRadius.circular(30),
            ),
      ),
      onSubmitted: onSubmitted,
    );
  }

  // Şifre alanına odaklanma fonksiyonu
  void _focusPasswordField() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  // Fradient buton oluşturma fonksiyonu
  Widget _buildGradientButton({
    required VoidCallback onPressed,
    required String text,
    required List<Color> colors,
    required Color textColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 18, color: textColor),
        ),
      ),
    );
  }

  // Yükleniyor göstergesi oluşturma fonksiyonu
  Widget _buildLoadingIndicator() {
    return const LoadingAnimation();
  }

  // Kullanıcı girişi fonksiyonu
  Future<void> _login() async {
    
    setState(() {
        _isLoading = true; // Yükleniyor durumunu başlat
    });

    String username = _usernameController.text; // Kullanıcı adını al
    String password = _passwordController.text; // Şifreyi al
    String hashedPassword = _hashPassword(password); // Şifreyi hash'le

    var user = await MongoDatabase.fetchUserByUsername(username); // Kullanıcıyı veritabanından al
    print(user); // Kullanıcı bilgilerini kontrol et


    if (!mounted) return;

    if (user != null && user['password'] == hashedPassword) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username); // Kullanıcı adını sakla
      await prefs.setString('password', password); // Şifreyi sakla

      // başarılı giriş yaptıysa uygun ekrana yönlendir
      if (user['admin'] == true) {
        Navigator.restorablePushNamedAndRemoveUntil(
          context,
          '/admin',
          (Route<dynamic> route) => false,
        );
      }
    }else {
      // Hatalı giriş durumu için kullanıcıya mesaj göster
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kullanıcı adı veya şifre hatalı'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    setState(() {
        _isLoading = false; // Yükleniyor durumunu kapat
    });
}



  // Şifreyi hash'leme fonksiyonu
   String _hashPassword(String password) {
    final bytes = utf8.encode(password); // Şifreyi byte dizisine çevir
    final digest = sha256.convert(bytes); // SHA-256 ile hash'le
    return digest.toString(); // Hash'lenmiş şifreyi döndür
  }
}