import 'package:flutter/material.dart';
import '../models/mahasiswa.dart';
import '../helpers/db_helper.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  List<Mahasiswa> _mahasiswaList = [];
  String query = "";

  final _namaController = TextEditingController();
  final _nimController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    final data = await DatabaseHelper.instance.getAllMahasiswa();
    setState(() {
      _mahasiswaList = data;
    });
  }

  Future<void> _addData() async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Tambah Mahasiswa"),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: "Nama"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama wajib diisi";
                  }
                  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                    return "Nama hanya boleh huruf";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nimController,
                decoration: const InputDecoration(labelText: "NIM"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "NIM wajib diisi";
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return "NIM hanya boleh angka";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Batal"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Simpan"),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final mahasiswa = Mahasiswa(
                  nama: _namaController.text,
                  nim: _nimController.text,
                );
                await DatabaseHelper.instance.insertMahasiswa(mahasiswa);

                _namaController.clear();
                _nimController.clear();

                Navigator.pop(context);
                _refreshData();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _deleteData(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('mahasiswa', where: 'id = ?', whereArgs: [id]);
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    // 🔎 filter dengan query
    final hasil = _mahasiswaList
        .where((m) =>
    m.nama.toLowerCase().contains(query.toLowerCase()) ||
        m.nim.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Data Mahasiswa")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: const InputDecoration(
                labelText: "Cari nama / NIM",
                border: OutlineInputBorder(),
              ),
              onChanged: (val) {
                setState(() {
                  query = val;
                });
              },
            ),
          ),
          Expanded(
            child: hasil.isEmpty
                ? const Center(child: Text("Data kosong"))
                : ListView.builder(
              itemCount: hasil.length,
              itemBuilder: (context, index) {
                final m = hasil[index];
                return Card(
                  child: ListTile(
                    title: Text(m.nama),
                    subtitle: Text("NIM: ${m.nim}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteData(m.id!),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addData,
        child: const Icon(Icons.add),
      ),
    );
  }
}
