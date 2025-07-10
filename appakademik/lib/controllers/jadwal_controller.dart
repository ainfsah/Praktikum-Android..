import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/jadwal.dart';

class JadwalService {
  final String baseUrl = 'http://10.0.2.2:8000/api/jadwal'; // Ganti dengan URL API Anda

  Future<List<Jadwal>> getJadwal() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Jadwal.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Jadwal> createJadwal(Jadwal jadwal) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(jadwal.toJson()),
    );

    if (response.statusCode == 201) {
      return Jadwal.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create jadwal');
    }
  }

  Future<Jadwal> updateJadwal(int id, Jadwal jadwal) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(jadwal.toJson()),
    );

    if (response.statusCode == 200) {
      return Jadwal.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update jadwal');
    }
  }

  Future<void> deleteJadwal(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete jadwal');
    }
  }
}