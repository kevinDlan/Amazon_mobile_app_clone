import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String value;
  final VoidCallback onTap;
  final Color? color;
  const CustomButton({Key? key, required this.value, required this.onTap, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
        primary: color
      ),
      child: Text(value, style: TextStyle(color: color == null ? Colors.white : Colors.black),),
    );
  }
}
