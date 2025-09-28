import 'package:flutter/material.dart';
import 'models/materi.dart';
import 'materi_detail_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Daftar materi perkuliahan
  List<Materi> allMateri = [
    Materi(
      judul: "Algoritma Dasar",
      kategori: "Algoritma",
      deskripsi: "Pengenalan logika, struktur dasar algoritma, dan contoh implementasi.",
      kodeAkses: "aXdwC",
    ),
    Materi(
      judul: "Struktur Data",
      kategori: "Algoritma",
      deskripsi: "Stack, Queue, Linked List, dan Tree.",
      kodeAkses: "sTrD4",
    ),
    Materi(
      judul: "SQL Dasar",
      kategori: "Basis Data",
      deskripsi: "Dasar perintah SQL: SELECT, INSERT, UPDATE, DELETE.",
      kodeAkses: "SqL09",
    ),
    Materi(
      judul: "Normalisasi Database",
      kategori: "Basis Data",
      deskripsi: "Teori normalisasi hingga BCNF dengan contoh tabel.",
      kodeAkses: "nRmDB",
    ),
    Materi(
      judul: "Jaringan Komputer",
      kategori: "Jaringan",
      deskripsi: "Konsep dasar jaringan, model OSI, dan protokol TCP/IP.",
      kodeAkses: "jRNet",
    ),
  ];

  String query = "";
  String selectedKategori = "Semua";

  @override
  Widget build(BuildContext context) {
    // Filter list berdasarkan pencarian & kategori
    List<Materi> filtered = allMateri.where((materi) {
      final matchJudul = materi.judul.toLowerCase().contains(query.toLowerCase());
      final matchKategori = selectedKategori == "Semua" || materi.kategori == selectedKategori;
      return matchJudul && matchKategori;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Materi Perkuliahan"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "logout") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "logout",
                child: Text("Logout"),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search box
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: "Cari materi...",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (val) {
                setState(() => query = val);
              },
            ),
          ),

          // Dropdown filter kategori
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButtonFormField<String>(
              value: selectedKategori,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Pilih kategori",
              ),
              items: ["Semua", "Algoritma", "Basis Data", "Jaringan"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) {
                setState(() => selectedKategori = val!);
              },
            ),
          ),

          const SizedBox(height: 10),

          // List materi
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text("Tidak ada materi ditemukan"))
                : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final materi = filtered[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(materi.judul),
                    subtitle: Text(materi.deskripsi),
                    trailing: Chip(label: Text(materi.kategori)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MateriDetailPage(materi: materi),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
