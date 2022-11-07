import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thiaopai/widget/gridviewAttraction.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  int crossAxisCount = 2;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'หน้าแรก',
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
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("${data['Email']}"),
            // Text("${data['Password']}"),
            // Text(uid),
            // Center(
            //   child: ElevatedButton(
            //     onPressed: () {
            //       FirebaseAuth.instance.signOut();
            //       Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const LoginScreen(),
            //         ),
            //       );
            //     },
            //     child: const Text("Log Out"),
            //   ),
            // ),
            Row(
              children: [
                Container(
                  width: 200,
                  decoration: const BoxDecoration(
                    color: Color(0xff71D3FF),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'สถานที่ท่องเที่ยว',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    if (crossAxisCount == 2) {
                      setState(() {
                        crossAxisCount = 1;
                      });
                    } else {
                      setState(() {
                        crossAxisCount = 2;
                      });
                    }
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xff71D3FF),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Icon(
                      crossAxisCount == 2
                          ? Icons.list_rounded
                          : Icons.grid_3x3_rounded,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            GridAttraction(
              crossAxisCount: crossAxisCount,
            )
          ],
        ),
      ),
    );
  }
}
