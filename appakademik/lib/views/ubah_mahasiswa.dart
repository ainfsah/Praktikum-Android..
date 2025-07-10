import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/mahasiswa_controller.dart';
import '../models/mahasiswa.dart';

class EditMahasiswaView extends StatefulWidget {
  final Mahasiswa mahasiswa;

  EditMahasiswaView({super.key, required this.mahasiswa});

  @override
  _EditMahasiswaViewState createState() => _EditMahasiswaViewState();
}

class _EditMahasiswaViewState extends State<EditMahasiswaView> {
  final MahasiswaController controller = Get.find();

  // Controller untuk setiap input field
  final TextEditingController npmController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telpController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController tempatLahirController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();
  final TextEditingController sexController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Isi controller dengan data awal dari mahasiswa
    final m = widget.mahasiswa;
    npmController.text = m.npm;
    namaController.text = m.nama;
    emailController.text = m.email;
    telpController.text = m.telp;
    alamatController.text = m.alamat;
    tempatLahirController.text = m.tempatLahir;
    tanggalLahirController.text = m.tanggalLahir;
    sexController.text = m.sex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Mahasiswa")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                  // Buat objek mahasiswa yang telah diperbarui
                  final updatedMahasiswa = Mahasiswa(
                    id: widget.mahasiswa.id,
                    npm: npmController.text,
                    nama: namaController.text,
                    email: emailController.text,
                    telp: telpController.text,
                    alamat: alamatController.text,
                    tempatLahir: tempatLahirController.text,
                    tanggalLahir: tanggalLahirController.text,
                    sex: sexController.text,
                    photo: widget.mahasiswa.photo, // Pertahankan foto lama
                  );

                  // Update melalui controller
                  controller.updateMahasiswa(
                    widget.mahasiswa.id!,
                    updatedMahasiswa,
                  );
                  Get.back(); // Kembali ke halaman sebelumnya
                },
                child: Text("Simpan Perubahan"),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
