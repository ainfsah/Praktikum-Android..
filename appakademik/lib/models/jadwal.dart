class Jadwal {
  final int? id;
  final String namaMatakuliah;
  final String tanggal;
  final String jam;
  final String ruangan;

  Jadwal({
    this.id,
    required this.namaMatakuliah,
    required this.tanggal,
    required this.jam,
    required this.ruangan,
  });

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      id: json['id'],
      namaMatakuliah: json['nama_matakuliah'],
      tanggal: json['tanggal'],
      jam: json['jam'],
      ruangan: json['ruangan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_matakuliah': namaMatakuliah,
      'tanggal': tanggal,
      'jam': jam,
      'ruangan': ruangan,
    };
  }
}
