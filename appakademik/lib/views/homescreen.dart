
import 'package:flutter/material.dart';
import 'mahasiswa_view01.dart';
import 'matakuliah_view.dart';
import 'jadwal_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Image.network(
                    'https://uniska-bjm.ac.id/wp-content/uploads/2021/08/logo-uniska-ok-300x300.png', 
                    fit: BoxFit.fill, 
                    width: 100, 
                    height: 90, 
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Admin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.emoji_people_rounded),
              title: Text('Mahasiswa'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MahasiswaView()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.verified_user_sharp),
              title: Text('Mata Kuliah'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MataKuliahView()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: Text('Jadwal Kuliah'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JadwalPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'PRAKTIKUM MOBILE SEMESTER 7/8',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}