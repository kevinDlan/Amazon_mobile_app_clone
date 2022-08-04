import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/account/widget/single_product.dart';
import 'package:amazon/features/admin/services/admin_services.dart';
import 'package:amazon/features/order_details/screens/order_details.dart';
import 'package:amazon/models/order.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final AdminService adminService = AdminService();
  List<Order>? orders;
  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await adminService.getAllOrders(context);
    setState(() {});
  }

  void navigateToOrderDetails(Order order) {
    Navigator.pushNamed(context, OrderDetailsScreen.routeName,
        arguments: order);
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : GridView.builder(
            itemCount: orders!.length,
            itemBuilder: (context, index) {
              final order = orders![index];
              return GestureDetector(
                onTap: () => navigateToOrderDetails(order),
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(
                    imageLink: order.products[0].images[0],
                  ),
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
          );
  }
}
