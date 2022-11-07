import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thiaopai/screen/login_screen.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'เกี่ยวกับ',
          style: TextStyle(
            color: Color(0xff71D3FF),
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(2, 2),
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, left: 30, right: 30),
                  child: Column(children: [
                    const Text(
                      'เกี่ยวกับแอปพลิเคชัน',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const Text(
                      'ระบบแนะนำสถานที่ท่องเที่ยวและค้นหาเส้นทางสถานที่ท่องเที่ยวรายบุคคลบนแอปพลิเคชันมือถือในจังหวัดชลบุรี โครงงานนี้เป็นส่วนหนึ่งของการศึกษาตามหลักสูตรปริญญาวิทยาศาสตร์บัณฑิต สาขาวิทยาการคอมพิวเตอร์ คณะวิทยาศาสตร์และเทคโนโลยี มหาวิทยาลัยราชภัฏสวนสุนันทา ปีการศึกษา 2564',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const Text(
                      'จัดทำโดย',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 10),
                      child: Container(
                        width: 120,
                        height: 120,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/img/meperson.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Text(
                      'นายณัฐพล ไชยหนองบัว รหัสนักศึกษา 62122201007',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            GestureDetector(
              child: Container(
                width: 200,
                height: 48,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Color(0xff71D3FF),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(2, 2),
                      ),
                    ]),
                child: const Text(
                  'ออกจากระบบ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
            Flexible(flex: 2, child: Container()),
            const Text(
              'Power by: Travel Link (https://catalog.travellink.go.th/)',
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
