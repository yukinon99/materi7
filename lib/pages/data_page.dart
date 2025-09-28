import 'package:flutter/material.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final List<String> mahasiswa = ["Andi - 123", "Budi - 456", "Citra - 789"];
  String query = "";

  void _addData() {
    setState(() {
      mahasiswa.add("Mahasiswa Baru - ${mahasiswa.length + 1}");
    });
  }

  void _deleteData(int index) {
    setState(() {
      mahasiswa.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasil = mahasiswa
        .where((m) => m.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Data Mahasiswa")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: const InputDecoration(
                labelText: "Cari nama",
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
            child: ListView.builder(
              itemCount: hasil.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(hasil[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteData(index),
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
