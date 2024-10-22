import 'package:flutter/material.dart';
import 'package:findik_muhasebe/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false; // Yükleniyor durumu için

  // Giriş işlemi
  void _login() async {
    setState(() {
      _isLoading = true; // Yükleniyor durumunu başlat
    });

    String username = _usernameController.text;
    String password = _passwordController.text;

    var user = await _authService.login(username, password);

    setState(() {
      _isLoading = false; // Yükleniyor durumu sona erdi
    });

    if (user != null) {
      // Giriş başarılı, ana ekrana yönlendir
      Navigator.pushReplacementNamed(context, '/home'); // Ana ekran rotasını belirtin
    } else {
      // Giriş başarısız, hata mesajı göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Giriş başarısız. Kullanıcı adı veya şifre hatalı.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Giriş Yap')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Şifre'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator() // Yüklenme durumunu göster
                : ElevatedButton(
                    onPressed: _login,
                    child: Text('Giriş Yap'),
                  ),
          ],
        ),
      ),
    );
  }
}
