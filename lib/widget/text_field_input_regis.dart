import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:thiaopai/model/register_model.dart';

class EmailTextfieldRegister extends StatefulWidget {
  EmailTextfieldRegister(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      required this.labelText,
      required this.icons,
      required this.textInputType,
      required this.registerModel});

  final TextEditingController textEditingController;
  final Icon icons;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;
  RegisterModel registerModel;

  @override
  State<EmailTextfieldRegister> createState() => _EmailTextfieldRegisterState();
}

class _EmailTextfieldRegisterState extends State<EmailTextfieldRegister> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (newValue) => widget.registerModel.email = newValue!,
      validator: MultiValidator([
        EmailValidator(errorText: "รูปแบบอีเมลให้ถูกต้อง"),
        RequiredValidator(errorText: "กรุณากรอกอีเมล"),
      ]),
      style: const TextStyle(
        color: Color(0xff212121),
      ),
      controller: widget.textEditingController,
      decoration: InputDecoration(
        prefixIcon: widget.icons,
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: Color(0xff71D3FF),
          fontSize: 18,
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Color.fromARGB(78, 33, 33, 33),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: GradientOutlineInputBorder(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 10, 175, 252),
              Color.fromARGB(255, 197, 237, 255),
              Color(0xff71D3FF),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: GradientOutlineInputBorder(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 10, 175, 252),
              Color.fromARGB(255, 197, 237, 255),
              Color(0xff71D3FF),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: widget.textInputType,
    );
  }
}

class PassTextfieldRegister extends StatefulWidget {
  PassTextfieldRegister(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      required this.labelText,
      required this.icons,
      required this.textInputType,
      required this.registerModel});

  final TextEditingController textEditingController;
  final Icon icons;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;
  RegisterModel registerModel;

  @override
  State<PassTextfieldRegister> createState() => _PassTextfieldRegisterState();
}

class _PassTextfieldRegisterState extends State<PassTextfieldRegister> {
  bool visiblepass = true;

  onTap_visibilityicon() {
    setState(() {
      visiblepass = !visiblepass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (newValue) => widget.registerModel.password = newValue!,
      validator: MultiValidator([
        RequiredValidator(errorText: "กรุณากรอกรหัสผ่าน"),
        MinLengthValidator(6, errorText: "กรุณากรอกรหัสผ่านอย่างน้อย 6 ตัว")
      ]),
      style: const TextStyle(
        color: Color(0xff212121),
      ),
      controller: widget.textEditingController,
      decoration: InputDecoration(
        prefixIcon: widget.icons,
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: Color(0xff71D3FF),
          fontSize: 18,
        ),
        suffixIcon: GestureDetector(
          onTap: onTap_visibilityicon,
          child: Icon(
            visiblepass ? Icons.visibility : Icons.visibility_off,
            color: Color(0xff71D3FF),
          ),
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Color.fromARGB(78, 33, 33, 33),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: GradientOutlineInputBorder(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 10, 175, 252),
              Color.fromARGB(255, 197, 237, 255),
              Color(0xff71D3FF),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: GradientOutlineInputBorder(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 10, 175, 252),
              Color.fromARGB(255, 197, 237, 255),
              Color(0xff71D3FF),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: widget.textInputType,
      obscureText: visiblepass,
    );
  }
}
