import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: const Text(
            "Deal of the day",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Image.network(
          "https://images.unsplash.com/photo-1657659558323-08b7854ed766?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
          height: 235,
          fit: BoxFit.fitHeight,
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 4, right: 40),
          child: const Text("\$100", style: TextStyle(fontSize: 18)),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15, top: 4, right: 40),
          child: const Text(
            "Kevin KONE",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                  "https://images.unsplash.com/photo-1657659558323-08b7854ed766?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100),
              Image.network(
                  "https://images.unsplash.com/photo-1657659558323-08b7854ed766?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100),
              Image.network(
                  "https://images.unsplash.com/photo-1657659558323-08b7854ed766?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100),
              Image.network(
                  "https://images.unsplash.com/photo-1657659558323-08b7854ed766?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
          alignment: Alignment.topLeft,
          child:  Text("See ALL", style: TextStyle(color: Colors.cyan[800])),
        )
      ],
    );
  }
}
