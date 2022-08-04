import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/admin/services/admin_services.dart';
import 'package:amazon/features/search/screen/search_screen.dart';
import 'package:amazon/models/order.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Order order;
  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);

  static const routeName = "/order-details";

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  TextEditingController searchTextFieldController = TextEditingController();
  int currentStep = 0;
  final AdminService adminService = AdminService();

  void navigateToSearchScreen(searchQuery) {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: searchQuery);
  }

  void updateOrderStatus(int status) async {
    adminService.updateOrderStatus(
        context: context,
        order: widget.order,
        status: status + 1,
        onSuccess: () {
          setState(() {
            currentStep += 1;
          });
        });
  }

  @override
  void dispose() {
    super.dispose();
    searchTextFieldController.dispose();
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  alignment: Alignment.topLeft,
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      controller: searchTextFieldController,
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        hintText: "Search Amazon.in",
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(Icons.search, color: Colors.black),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide: BorderSide.none),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            borderSide:
                                BorderSide(color: Colors.black38, width: 1)),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black12, size: 25),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'View Order Details',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black12, style: BorderStyle.solid)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Order Date: ${DateFormat().format(DateTime.fromMicrosecondsSinceEpoch(widget.order.orderAt))}"),
                  Text("Order Id : ${widget.order.id}"),
                  Text("Order Total : \$${widget.order.totalPrice}"),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Purchase Details",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black12, style: BorderStyle.solid)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < widget.order.products.length; i++)
                    Row(
                      children: [
                        Image.network(
                          widget.order.products[i].images[0],
                          height: 120,
                          width: 120,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.order.products[i].name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            Text("Qty: ${widget.order.quantity[i]}")
                          ],
                        ))
                      ],
                    )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Tracking",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
              child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details) => user.type == "admin"
                      ? CustomButton(
                          value: "Done",
                          onTap: () => updateOrderStatus(details.currentStep))
                      : const SizedBox(),
                  steps: [
                    Step(
                        title: const Text("Pending"),
                        content:
                            const Text("Your order is yet to be delivered"),
                        isActive: currentStep > 0,
                        state: currentStep > 0
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: const Text("Completed"),
                        content: const Text(
                            "Your order has been, delivered, you are yet to sign."),
                        isActive: currentStep > 1,
                        state: currentStep > 1
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: const Text("Received"),
                        content: const Text(
                            "You order has been delivered and sign by you."),
                        isActive: currentStep > 2,
                        state: currentStep > 2
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: const Text("Delivered"),
                        content: const Text(
                            "YYou order has been delivered and sign by you."),
                        isActive: currentStep >= 3,
                        state: currentStep >= 3
                            ? StepState.complete
                            : StepState.indexed)
                  ]),
            )
          ],
        ),
      )),
    );
  }
}
