import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String value;
  final VoidCallback ontap;
  const CustomButton({Key? key, required this.value, required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50)),
      child: Text(value),
    );
  }
}
