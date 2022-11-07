import 'package:flutter/material.dart';
import 'package:thiaopai/screen/home_screen.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.myGradient,
  });

  final LinearGradient myGradient;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const HomeScreen();
        }));
      },
      child: Container(
        height: 48,
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            gradient: myGradient,
            boxShadow: const [
              BoxShadow(
                color: Color(0xffCFD8DC),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: const Text(
          "เข้าสู่ระบบ",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
