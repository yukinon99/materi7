import 'package:flutter/material.dart';
import 'models/materi.dart';

class MateriDetailPage extends StatelessWidget {
  final Materi materi;

  const MateriDetailPage({super.key, required this.materi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(materi.judul)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              materi.judul,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Tampilkan kode akses
            Row(
              children: [
                const Icon(Icons.vpn_key, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  "Kode Akses: ${materi.kodeAkses}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              "Penjelasan:",
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Text(
              materi.deskripsi,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
