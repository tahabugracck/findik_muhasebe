// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:findik_muhasebe/services/auth_service.dart';
import 'package:findik_muhasebe/widgets/theme_notifier.dart';
import 'package:provider/provider.dart'; // Provider paketi ekleniyor

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false; // Yükleniyor durumu için
  bool _obscureText = true; // Şifre görünürlüğü için
  String? _errorMessage; // Hata mesajı için

  // Giriş işlemi
  void _login() async {
    setState(() {
      _isLoading = true; // Yükleniyor durumunu başlat
      _errorMessage = null; // Önceki hata mesajını sıfırla
    });

    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    // Form validasyonu
    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Kullanıcı adı ve şifre boş bırakılamaz.';
      });
      return;
    }

    var user = await _authService.login(username, password);

    setState(() {
      _isLoading = false; // Yükleniyor durumu sona erdi
    });

    if (user != null) {
      // Giriş başarılı, ana ekrana yönlendir
      Navigator.pushReplacementNamed(
        context,
        '/home',
        arguments: user, // Kullanıcı bilgisini geçir
      );
    } else {
      // Giriş başarısız, hata mesajı göster
      setState(() {
        _errorMessage = 'Giriş başarısız. Kullanıcı adı veya şifre hatalı.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tema sağlayıcısı
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş Yap'),
      ),
      body: Row(
        children: [
          // Sol taraf: GIF
          Expanded(
            child: Container(
              color: Colors.white,
              child: Center(
                child: Image.asset(
                  'assets/login_animation.gif', // Projeye eklediğin GIF
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Sağ taraf: Giriş formu
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0), // Daha geniş padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hesabınıza Giriş Yapın',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Kullanıcı Adı',
                      border: OutlineInputBorder(), // Daha modern bir tasarım için kenarlık
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Şifre',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText; // Göz ikonuna tıklanınca şifre görünürlüğünü değiştir
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator()) // Ortada dönen yükleme animasyonu
                      : SizedBox(
                          width: double.infinity, // Buton genişliği tam ekran
                          child: ElevatedButton(
                            onPressed: _login,
                            child: const Text('Giriş Yap'),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
