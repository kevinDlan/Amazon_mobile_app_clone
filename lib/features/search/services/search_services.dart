import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../constants/error_handle.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';
import 'package:http/http.dart' as http;

class SearchServices
{
  Future<List<Product>> fetchSearchedProduct(
      {required BuildContext context, required String searchQuery}) async {
    List<Product> products = [];
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response productResult = await http
          .get(Uri.parse("$uri/products/search/$searchQuery"), headers: {
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
    } catch (e)
    {
      debugPrint("Error : ${e.toString()}");
      showSnackBar(context, e.toString());
    }
    return products;
  }
}