import 'package:flutter/material.dart';


class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:const [
         CircularProgressIndicator(),
          SizedBox(height: 10),
          Text("Loading..."),
        ],
      ),
    );
  }
}
