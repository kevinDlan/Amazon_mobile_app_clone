import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/account/widget/single_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  List tempOrders = [
    "https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
    "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80",
    "https://images.unsplash.com/photo-1596558450268-9c27524ba856?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1450&q=80"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
             const Text("You Order", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
             Text("See All",style:TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: GlobalVariables.selectedNavBarColor)),

          ],
          ),
        ),
        //display Order product
        Container(
          height: 170.0,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
               itemCount: tempOrders.length,
              itemBuilder: ((context, index)
              {
                  return SingleProduct(imageLink: tempOrders[index]);
              })
          ),
        )
      ],
    );
  }
}
