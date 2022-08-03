import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/features/cart/widgets/cart_product.dart';
import 'package:amazon/features/cart/widgets/cart_subtotal.dart';
import 'package:amazon/features/home/widgets/address_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';
import '../../address/screens/address_screen.dart';
import '../../search/screen/search_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(searchQuery) {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: searchQuery);
  }

  void navigateToAddressScreen(int sum)
  {
    Navigator.pushNamed(context, AddressScreen.routeName, arguments: sum.toString());
  }

  TextEditingController searchTextField = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchTextField.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart.map((p) => sum += p['quantity']*p['product']['price'] as int).toList();

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
                      controller: searchTextField,
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
        child: Column(
          children: [
            const AddressBox(),
            const CardSubtotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                value: "Proceed to Buy (${user.cart.length} item(s))",
                onTap: () => navigateToAddressScreen(sum),
                color: Colors.yellow[600],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            const SizedBox(height: 5),
            ListView.builder(
                itemCount: user.cart.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CartProduct(index: index);
                })
          ],
        ),
      ),
    );
  }
}
