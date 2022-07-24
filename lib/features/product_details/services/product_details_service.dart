import 'dart:convert';
import 'package:amazon/models/product.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/error_handle.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';


class ProductDetailsService
{
  void rateProduct(BuildContext context, Product product, double rating) async
  {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response resp = await http.post(
        Uri.parse('$uri/rate-product'),
        headers:
        {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({
          "id":product.id!,
          "rating":rating
        }),
      );
      print(resp.body);
      httErrorHandle(
          context: context,
          response: resp,
          onSuccess: () {
            showSnackBar(context, "Rating added successfully");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }

  }
}