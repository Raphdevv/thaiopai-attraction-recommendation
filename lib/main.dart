import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:thiaopai/screen/about_screen.dart';
import 'package:thiaopai/screen/login_screen.dart';
import 'package:thiaopai/screen/register_screen.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thiaopai',
      home: const LoginScreen(),
      theme: ThemeData(fontFamily: 'Opun-Regular'),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => const LoginScreen(),
        '/register': (BuildContext context) => const RegisterScreen(),
        '/about': (BuildContext context) => const AboutScreen(),
      },
    );
  }
}
