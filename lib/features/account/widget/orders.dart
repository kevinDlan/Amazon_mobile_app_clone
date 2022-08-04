import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/account/services/account_service.dart';
import 'package:amazon/features/account/widget/single_product.dart';
import 'package:amazon/features/order_details/screens/order_details.dart';
import 'package:amazon/models/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountService accountService = AccountService();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountService.fetchUserOrderProducts(context: context);
    setState(() {});
  }

  void navigateToDetail(Order order) {
    Navigator.pushNamed(context, OrderDetailsScreen.routeName,
        arguments: order);
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("You Order",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("See All",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: GlobalVariables.selectedNavBarColor)),
                  ],
                ),
              ),
              //display Order product
              Container(
                height: 170.0,
                padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: orders?.length,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () => navigateToDetail(orders![index]),
                        child: SingleProduct(
                            imageLink: orders![index].products[0].images[0]),
                      );
                    })),
              )
            ],
          );
  }
}
