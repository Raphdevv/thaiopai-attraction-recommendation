import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:thiaopai/model/login_model.dart';

class TextInputEmailLogin extends StatefulWidget {
  TextInputEmailLogin(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      required this.labelText,
      required this.icons,
      required this.textInputType,
      required this.loginModel});

  final TextEditingController textEditingController;
  final Icon icons;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;
  LoginModel loginModel;

  @override
  State<TextInputEmailLogin> createState() => _TextInputEmailLoginState();
}

class _TextInputEmailLoginState extends State<TextInputEmailLogin> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (newValue) => widget.loginModel.email = newValue!,
      validator: MultiValidator([
        EmailValidator(errorText: "รูปแบบอีเมลให้ถูกต้อง"),
        RequiredValidator(errorText: "กรุณากรอกอีเมล"),
      ]),
      style: const TextStyle(color: Colors.white),
      controller: widget.textEditingController,
      decoration: InputDecoration(
        prefixIcon: widget.icons,
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Colors.white60,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: widget.textInputType,
    );
  }
}

class PassTextfieldLogin extends StatefulWidget {
  PassTextfieldLogin(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      required this.labelText,
      required this.icons,
      required this.textInputType,
      required this.loginModel});

  final TextEditingController textEditingController;
  final Icon icons;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;
  LoginModel loginModel;

  @override
  State<PassTextfieldLogin> createState() => _PassTextfieldLoginState();
}

class _PassTextfieldLoginState extends State<PassTextfieldLogin> {
  bool visiblepass = true;

  onTap_visibilityicon() {
    setState(() {
      visiblepass = !visiblepass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (newValue) => widget.loginModel.password = newValue!,
      validator: MultiValidator([
        RequiredValidator(errorText: "กรุณากรอกรหัสผ่าน"),
        MinLengthValidator(6, errorText: "กรุณากรอกรหัสผ่านอย่างน้อย 6 ตัว")
      ]),
      style: const TextStyle(color: Colors.white),
      controller: widget.textEditingController,
      decoration: InputDecoration(
        prefixIcon: widget.icons,
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        suffixIcon: GestureDetector(
          onTap: onTap_visibilityicon,
          child: Icon(
            visiblepass ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Colors.white60,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: widget.textInputType,
      obscureText: visiblepass,
    );
  }
}
