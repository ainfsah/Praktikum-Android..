import 'package:flutter/material.dart';
import 'package:appakademik/models/jadwal.dart';
import 'package:appakademik/controllers/jadwal_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class JadwalPage extends StatefulWidget {
  @override
  _JadwalPageState createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  final JadwalService _service = JadwalService();
  List<Jadwal> _jadwalList = [];

  @override
  void initState() {
    super.initState();
    _fetchJadwal();
  }

  Future<void> _fetchJadwal() async {
    List<Jadwal> jadwalList = await _service.getJadwal();
    setState(() {
      _jadwalList = jadwalList;
    });
  }

  Future<void> generatePdf(List<Jadwal> jadwals) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text(
                'Laporan Jadwal Kuliah',
                style: pw.TextStyle(fontSize: 24),
              ),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: ['Nama Mata Kuliah', 'Tanggal', 'Jam', 'Ruangan'],
                data: jadwals.map((jadwal) {
                  return [
                    jadwal.namaMatakuliah,
                    jadwal.tanggal,
                    jadwal.jam,
                    jadwal.ruangan,
                  ];
                }).toList(),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  void _showForm(BuildContext context, {Jadwal? jadwal}) {
    final isEdit = jadwal != null;

    final namaMatakuliahController = TextEditingController(
      text: isEdit ? jadwal!.namaMatakuliah : '',
    );
    final tanggalController = TextEditingController(
      text: isEdit ? jadwal!.tanggal : '',
    );
    final jamController = TextEditingController(
      text: isEdit ? jadwal!.jam : '',
    );
    final ruanganController = TextEditingController(
      text: isEdit ? jadwal!.ruangan : '',
    );

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaMatakuliahController,
                  decoration: InputDecoration(labelText: 'Nama Mata Kuliah'),
                ),
                TextField(
                  controller: tanggalController,
                  decoration: InputDecoration(
                    labelText: 'Tanggal (YYYY-MM-DD)',
                  ),
                ),
                TextField(
                  controller: jamController,
                  decoration: InputDecoration(labelText: 'Jam'),
                ),
                TextField(
                  controller: ruanganController,
                  decoration: InputDecoration(labelText: 'Ruangan'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text(isEdit ? 'Update' : 'Simpan'),
                  onPressed: () {
                    final newJadwal = Jadwal(
                      id: isEdit ? jadwal!.id : null,
                      namaMatakuliah: namaMatakuliahController.text,
                      tanggal: tanggalController.text,
                      jam: jamController.text,
                      ruangan: ruanganController.text,
                    );
                    if (isEdit) {
                      _service.updateJadwal(jadwal!.id!, newJadwal).then((_) {
                        _fetchJadwal();
                        Navigator.pop(context);
                      });
                    } else {
                      _service.createJadwal(newJadwal).then((_) {
                        _fetchJadwal();
                        Navigator.pop(context);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteJadwal(int id) {
    _service.deleteJadwal(id).then((_) {
      _fetchJadwal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () async {
              List<Jadwal> jadwals = await _service.getJadwal();
              await generatePdf(jadwals);
            },
          ),
        ],
      ),
      body: _jadwalList.isEmpty
          ? Center(child: Text('Tidak ada data jadwal.'))
          : ListView.builder(
              itemCount: _jadwalList.length,
              itemBuilder: (context, index) {
                final jadwal = _jadwalList[index];
                return ListTile(
                  title: Text(jadwal.namaMatakuliah),
                  subtitle: Text(
                    '${jadwal.tanggal} - ${jadwal.jam} (${jadwal.ruangan})',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showForm(context, jadwal: jadwal),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteJadwal(jadwal.id!),
                      ),
                    ],
                  ),
                  onTap: () => _showForm(context, jadwal: jadwal),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showForm(context),
      ),
    );
  }
}
