import 'package:crud/pages/read_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:crud/pages/home.dart';


// Fungsi utama yang akan dieksekusi saat aplikasi dijalankan.
void main()async{
  // Memastikan bahwa binding Flutter telah diinisialisasi sebelum menjalankan aplikasi.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // coding tambahan yang saya temukan untuk membuat aplikasi berhasil dijalankan
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyListCafe',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color.fromARGB(255, 59, 44, 22),
        indicatorColor: Colors.orangeAccent,
      ),
            home: Home()
            // home: ReadData()
    );
  }
}
