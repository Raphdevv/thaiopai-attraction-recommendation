import 'package:flutter/material.dart';
import 'package:thiaopai/screen/home_screen.dart';
import 'package:thiaopai/screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('assets/background/bc_splash.jpg'),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              const Text(
                'ยินดีต้อนรับ',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'ขอให้คุณเพลิดเพลินไปกับการหาทริปท่องเที่ยวอย่างพอใจ!',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LoginScreen();
                  }));
                },
                child: Container(
                  height: 48,
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          spreadRadius: 1.2,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        )
                      ],
                      gradient: LinearGradient(colors: [
                        Color(0xff71D3FF),
                        Color(0xffC4F3FF),
                      ]),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: const Text(
                    "เข้าสู่ระบบ/ลงทะเบียน",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
