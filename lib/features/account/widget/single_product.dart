import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String imageLink;
  const SingleProduct({Key? key, required this.imageLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, width: 1.5),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Image.network(imageLink, fit: BoxFit.fitHeight, width: 180),
      ),
    );
  }
}
