import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // ID & password statis
  final String validId = "admin";
  final String validPassword = "12345";

  String? errorMessage;

  void _checkLogin() {
    final id = _idController.text.trim();
    final pass = _passwordController.text.trim();

    if (id == validId && pass == validPassword) {
      // Jika cocok → pindah otomatis ke HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else if (id.isNotEmpty && pass.isNotEmpty) {
      // Jika sudah terisi tapi salah → tampilkan error
      setState(() {
        errorMessage = "ID atau Password salah!";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // cek setiap kali field berubah
    _idController.addListener(_checkLogin);
    _passwordController.addListener(_checkLogin);
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: "Nama / ID",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            if (errorMessage != null) ...[
              const SizedBox(height: 20),
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
