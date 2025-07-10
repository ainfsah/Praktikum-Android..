import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/mahasiswa_controller.dart';
import '../models/mahasiswa.dart';

class TambahMahasiswaView extends StatelessWidget {
  TambahMahasiswaView({super.key});

  final MahasiswaController controller = Get.find();

  // TextEditingControllers untuk setiap field input
  final TextEditingController npmController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telpController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController tempatLahirController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();
  final TextEditingController sexController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Mahasiswa")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(npmController, "NPM"),
            _buildTextField(namaController, "Nama"),
            _buildTextField(emailController, "Email"),
            _buildTextField(telpController, "Telepon"),
            _buildTextField(alamatController, "Alamat"),
            _buildTextField(tempatLahirController, "Tempat Lahir"),
            _buildTextField(
              tanggalLahirController,
              "Tanggal Lahir (YYYY-MM-DD)",
            ),
            _buildTextField(sexController, "Jenis Kelamin (L/P)"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Buat objek Mahasiswa dari input pengguna
                final mahasiswa = Mahasiswa(
                  npm: npmController.text,
                  nama: namaController.text,
                  email: emailController.text,
                  telp: telpController.text,
                  tempatLahir: tempatLahirController.text,
                  tanggalLahir: tanggalLahirController.text,
                  sex: sexController.text,
                  alamat: alamatController.text,
                  photo: null, // Tambahkan jika ada input foto
                );

                // Simpan data dan kembali
                controller.addMahasiswa(mahasiswa);
                Get.back();
              },
              child: Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membuat TextField yang reusable
  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
