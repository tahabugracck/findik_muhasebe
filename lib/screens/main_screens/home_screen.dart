import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Hoşgeldiniz, burası ana sayfanız!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Toptancı ekranına gitmek için buton
                Navigator.pushNamed(context, '/toptanci');
              },
              child: const Text('Toptancı Ekranına Git'),
            ),
          ],
        ),
      ),
    );
  }
}
