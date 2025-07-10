import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:appakademik/models/mata_kuliah.dart';
import '../controllers/matakuliah_controller.dart';

class ApiService {
  // Gunakan ini jika testing di web lokal:
  // final String baseUrl = "http://localhost:8000/api/mata-kuliah";

  // Gunakan ini jika testing di emulator Android:
  final String baseUrl = "http://10.0.2.2:8000/api/mata-kuliah";

  Future<List<MataKuliah>> fetchMataKuliah() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => MataKuliah.fromJson(data)).toList();
    } else {
      throw Exception("Gagal untuk load mata kuliah");
    }
  }

  Future<MataKuliah> createMataKuliah(MataKuliah mataKuliah) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(mataKuliah.toJson()),
    );

    if (response.statusCode == 201) {
      return MataKuliah.fromJson(json.decode(response.body));
    } else {
      throw Exception("Gagal menambahkan data mata kuliah");
    }
  }

  Future<MataKuliah> updateMataKuliah(int id, MataKuliah mataKuliah) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(mataKuliah.toJson()),
    );

    if (response.statusCode == 200) {
      return MataKuliah.fromJson(json.decode(response.body));
    } else {
      throw Exception("Gagal memperbarui data mata kuliah");
    }
  }

  Future<void> deleteMataKuliah(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception("Gagal menghapus data mata kuliah");
    }
  }
}
