import 'package:amazon/features/cart/services/cart_service.dart';
import 'package:amazon/features/product_details/services/product_details_service.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/product.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({Key? key, required this.index}) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsService productDetailsService = ProductDetailsService();
  final CartService cartService = CartService();

  void increaseQuantity(Product product) {
    productDetailsService.addToCart(context: context, product: product);
  }

  void decreaseQuantity(Product product)
  {
    cartService.removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    var quantity = productCart["quantity"];
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(product.images[0],
                  fit: BoxFit.fitWidth, height: 135, width: 135),
              Column(
                children: [
                  Container(
                    width: 200,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 200,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      "\$ ${product.price}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text(
                      "Eligible for FREE Shipping",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.green),
                    ),
                  ),
                  Container(
                    width: 200,
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text(
                      "In Stock (10)",
                      style: TextStyle(color: Colors.teal),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 1.5),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => decreaseQuantity(product),
                      child: Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(Icons.remove),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1.5),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0)),
                      child: Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        child: Text("$quantity"),
                      ),
                    ),
                    InkWell(
                      onTap: () => increaseQuantity(product),
                      child: Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
