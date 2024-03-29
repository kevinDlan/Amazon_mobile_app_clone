import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/error_handle.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeServices {
  Future<List<Product>> fetchProductCategory(
      {required BuildContext context, required String category}) async {
    List<Product> products = [];
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response productResult = await http
          .get(Uri.parse("$uri/products?category=$category"), headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "x-auth-token": userProvider.user.token
      });
      httErrorHandle(
          response: productResult,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(productResult.body).length; i++) {
              products.add(Product.fromJson(
                  jsonEncode(jsonDecode(productResult.body)[i])));
            }
          });
    } catch (e) {
      debugPrint("Error : ${e.toString()}");
      showSnackBar(context, e.toString());
    }
    return products;
  }

  Future<Product> fetchDealOfDay(BuildContext context) async {
    Product product = Product(
        name: "",
        description: "",
        price: 0,
        quantity: 0,
        category: "",
        images: []);
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response productResult =
          await http.get(Uri.parse("$uri/deal-of-day"), headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "x-auth-token": userProvider.user.token
      });
      httErrorHandle(
          response: productResult, context: context, onSuccess: () {
            product = Product.fromJson(productResult.body);
      });
    } catch (e)
    {
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
