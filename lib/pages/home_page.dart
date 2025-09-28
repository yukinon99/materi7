import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: Text(
          "Selamat datang di Aplikasi UTS Mini 🎉",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
