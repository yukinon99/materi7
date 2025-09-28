class Mahasiswa {
  final int? id;
  final String nama;
  final String nim;

  Mahasiswa({this.id, required this.nama, required this.nim});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'nim': nim,
    };
  }

  factory Mahasiswa.fromMap(Map<String, dynamic> map) {
    return Mahasiswa(
      id: map['id'],
      nama: map['nama'],
      nim: map['nim'],
    );
  }
}
