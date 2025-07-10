import 'package:flutter/material.dart';
import '../controllers/matakuliah_controller.dart';
import '../models/mata_kuliah.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class MataKuliahView extends StatefulWidget {
  @override
  _MataKuliahListState createState() => _MataKuliahListState();
}

class _MataKuliahListState extends State<MataKuliahView> {
  late Future<List<MataKuliah>> futureMataKuliah;

  @override
  void initState() {
    super.initState();
    futureMataKuliah = ApiService().fetchMataKuliah();
  }

  Future<void> generatePdf(List<MataKuliah> mataKuliahs) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Laporan Mata Kuliah', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              // ignore: deprecated_member_use
              pw.Table.fromTextArray(
                headers: ['Kode', 'Mata Kuliah', 'SKS', 'Semester'],
                data: mataKuliahs.map((mataKuliah) {
                  return [
                    mataKuliah.kode,
                    mataKuliah.matakuliah,
                    mataKuliah.sks.toString(),
                    mataKuliah.semester.toString(),
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

  Future<void> _showForm(BuildContext context, {MataKuliah? mataKuliah}) {
    final kodeController = TextEditingController(text: mataKuliah?.kode);
    final matakuliahController = TextEditingController(
      text: mataKuliah?.matakuliah,
    );
    final sksController = TextEditingController(
      text: mataKuliah != null ? mataKuliah.sks.toString() : '',
    );
    final semesterController = TextEditingController(
      text: mataKuliah != null ? mataKuliah.semester.toString() : '',
    );

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            mataKuliah == null ? 'Tambah Mata Kuliah' : 'Ubah Mata Kuliah',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: kodeController,
                decoration: InputDecoration(labelText: 'Kode'),
              ),
              TextField(
                controller: matakuliahController,
                decoration: InputDecoration(labelText: 'Nama Mata Kuliah'),
              ),
              TextField(
                controller: sksController,
                decoration: InputDecoration(labelText: 'SKS'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: semesterController,
                decoration: InputDecoration(labelText: 'Semester'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (mataKuliah == null) {
                  // Tambah data
                  ApiService()
                      .createMataKuliah(
                        MataKuliah(
                          id: 0,
                          kode: kodeController.text,
                          matakuliah: matakuliahController.text,
                          sks: int.parse(sksController.text),
                          semester: int.parse(semesterController.text),
                        ),
                      )
                      .then((_) {
                        Navigator.of(context).pop();
                        setState(() {
                          futureMataKuliah = ApiService().fetchMataKuliah();
                        });
                      });
                } else {
                  // Ubah data
                  ApiService()
                      .updateMataKuliah(
                        mataKuliah.id,
                        MataKuliah(
                          id: mataKuliah.id,
                          kode: kodeController.text,
                          matakuliah: matakuliahController.text,
                          sks: int.parse(sksController.text),
                          semester: int.parse(semesterController.text),
                        ),
                      )
                      .then((_) {
                        Navigator.of(context).pop();
                        setState(() {
                          futureMataKuliah = ApiService().fetchMataKuliah();
                        });
                      });
                }
              },
              child: Text(mataKuliah == null ? 'Tambah' : 'Ubah'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteMataKuliah(int id) async {
    await ApiService().deleteMataKuliah(id);
    setState(() {
      futureMataKuliah = ApiService().fetchMataKuliah();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mata Kuliah'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showForm(context),
          ),
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () async {
              List<MataKuliah> mataKuliahs = await futureMataKuliah;
              await generatePdf(mataKuliahs);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<MataKuliah>>(
        future: futureMataKuliah,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Data Mata Kuliah kosong'));
          }

          List<MataKuliah> mataKuliahs = snapshot.data!;
          return ListView.builder(
            itemCount: mataKuliahs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(mataKuliahs[index].matakuliah),
                subtitle: Text(
                  'Kode: ${mataKuliahs[index].kode}, '
                  'SKS: ${mataKuliahs[index].sks}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () =>
                          _showForm(context, mataKuliah: mataKuliahs[index]),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteMataKuliah(mataKuliahs[index].id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
