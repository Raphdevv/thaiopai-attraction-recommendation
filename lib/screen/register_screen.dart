import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:thiaopai/model/register_model.dart';
import 'package:thiaopai/widget/progress.dart';
import 'package:thiaopai/widget/text_field_input_regis.dart';

import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conpasswordController = TextEditingController();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  RegisterModel registerModel = RegisterModel(email: '', password: '');

  final Map<String, dynamic> _users = HashMap();

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('Users');

  bool inAsyncCall = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _conpasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: inAsyncCall,
      child: _registerUI(context),
    );
  }

  Widget _registerUI(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 197, 237, 255),
              Color(0xff71D3FF),
              Color.fromARGB(255, 10, 175, 252),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            width: width * 0.9,
            height: height * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(1, 3),
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Form(
                key: globalFormKey,
                child: Column(
                  children: [
                    Flexible(flex: 2, child: Container()),
                    const Text(
                      "สมัครสมาชิก",
                      style: TextStyle(
                        fontSize: 32,
                        color: Color(0xff71D3FF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    EmailTextfieldRegister(
                        textEditingController: _emailController,
                        hintText: "อีเมลของคุณ",
                        labelText: "อีเมล",
                        icons: const Icon(
                          Icons.email,
                          color: Color(0xff71D3FF),
                        ),
                        textInputType: TextInputType.emailAddress,
                        registerModel: registerModel),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    PassTextfieldRegister(
                        textEditingController: _passwordController,
                        hintText: "กรุณากรอกรหัสผ่าน",
                        labelText: "รหัสผ่าน",
                        icons: const Icon(
                          Icons.lock,
                          color: Color(0xff71D3FF),
                        ),
                        textInputType: TextInputType.text,
                        registerModel: registerModel),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    InkWell(
                      onTap: submit_,
                      child: Container(
                        height: 48,
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 10, 175, 252),
                                Color(0xff71D3FF),
                                Color.fromARGB(255, 197, 237, 255),
                              ],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: const Text(
                          "สมัครสมาชิก",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    InkWell(
                      onTap: back,
                      child: Container(
                        height: 48,
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: const Text(
                          "ย้อนกลับ",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Flexible(flex: 2, child: Container()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  back() {
    Navigator.pop(context);
  }

  Future submit_() async {
    if (validateOnsaved()) {
      setState(() {
        inAsyncCall = true;
      });
      //สร้าง user ด้วย FirebaseAuth
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: registerModel.email, password: registerModel.password);

        String userID = firebaseAuth.currentUser!.uid;
        //สร้างข้อมูล user ด้วย firebase
        DocumentReference documentReference = _userReference.doc(userID);
        _users.addAll(
            {"Email": registerModel.email, "Password": registerModel.password});
        documentReference.set(_users).then((value) {
          setState(() {
            inAsyncCall = false;
          });
          globalFormKey.currentState!.reset();
          var snackBar = const SnackBar(content: Text("สร้างบัญชีสำเร็จ"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          inAsyncCall = false;
        });
        var snackBar = SnackBar(content: Text("${e.message}"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  bool validateOnsaved() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
