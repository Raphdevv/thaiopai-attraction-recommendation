import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thiaopai/model/login_model.dart';
import 'package:thiaopai/screen/home_screen.dart';
import 'package:thiaopai/screen/register_screen.dart';
import 'package:thiaopai/widget/progress.dart';
import 'package:thiaopai/widget/text_field_input_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  LoginModel loginModel = LoginModel(email: '', password: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  bool inAsyncCall = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: inAsyncCall,
      child: _loginUI(context),
    );
  }

  Widget _loginUI(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Container(
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
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  width: double.infinity,
                  child: Form(
                    key: globalFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(flex: 2, child: Container()),
                        Image.asset(
                          'assets/logo/ic_new.png',
                          height: 120,
                        ),
                        const SizedBox(
                          height: 64,
                        ),
                        TextInputEmailLogin(
                          textEditingController: _emailController,
                          hintText: "กรุณาใส่อีเมลของคุณ",
                          labelText: "อีเมล",
                          icons: const Icon(
                            Icons.email_rounded,
                            color: Colors.white,
                          ),
                          textInputType: TextInputType.emailAddress,
                          loginModel: loginModel,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        PassTextfieldLogin(
                          textEditingController: _passwordController,
                          hintText: "กรุณาใส่รหัสผ่านของคุณ",
                          labelText: "รหัสผ่าน",
                          icons: const Icon(Icons.lock_outline_rounded,
                              color: Colors.white),
                          textInputType: TextInputType.text,
                          loginModel: loginModel,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        InkWell(
                          onTap: login_,
                          child: Container(
                            height: 48,
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: const Text(
                              "เข้าสู่ระบบ",
                              style: TextStyle(
                                color: Color(0xff71D3FF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: const Text(
                                "ยังไม่มีบัญชีผู้ใช้ใช่ไหม? ",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: const Text(
                                  "กดที่นี่!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Flexible(flex: 2, child: Container()),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        }));
  }

  Future login_() async {
    if (validateOnsaved()) {
      setState(() {
        inAsyncCall = true;
      });
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: loginModel.email.trim(),
                password: loginModel.password.trim())
            .then((value) {
          setState(() {
            inAsyncCall = false;
          });
          Fluttertoast.showToast(
              msg: "เข้าสู่ระบบสำเร็จ",
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.green.shade300,
              textColor: Colors.white);

          globalFormKey.currentState!.reset();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          inAsyncCall = false;
        });
        String error = '';
        if (e.code == 'wrong-password') {
          error = "รหัสผ่านไม่ถูกต้อง";
        } else if (e.code == 'user-not-found') {
          error = "ไม่พบบัญชีผู้ใช้นี้";
        }
        var snackBar = SnackBar(content: Text(error));
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
