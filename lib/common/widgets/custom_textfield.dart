import 'package:flutter/material.dart';

class CustomTextFied extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isObscureTxt;
  const CustomTextFied(
      {Key? key,
      required this.controller,
      required this.hint,
      required this.isObscureTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscureTxt,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.black38),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.black38),
        ),
      ),
      validator: (val) {},
    );
  }
}
