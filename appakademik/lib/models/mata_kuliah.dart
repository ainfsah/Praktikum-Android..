class MataKuliah {
  final int id;
  final String kode;
  final String matakuliah;
  final int sks;
  final int semester;

  MataKuliah({
    required this.id,
    required this.kode,
    required this.matakuliah,
    required this.sks,
    required this.semester,
  });

  factory MataKuliah.fromJson(Map<String, dynamic> json) {
    return MataKuliah(
      id: json['id'],
      kode: json['kode'],
      matakuliah: json['matakuliah'],
      sks: json['sks'],
      semester: json['semester'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kode': kode,
      'matakuliah': matakuliah,
      'sks': sks,
      'semester': semester,
    };
  }
}
