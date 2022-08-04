import 'dart:convert';

import 'package:amazon/constants/error_handle.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/models/order.dart';
import 'package:amazon/providers/user_provider.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AccountService {
  Future<List<Order>> fetchUserOrderProducts(
      {required BuildContext context}) async {
    List<Order> orderList = [];
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response productResult =
          await http.get(Uri.parse("$uri/user-orders"), headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "x-auth-token": userProvider.user.token
      });
      httErrorHandle(
          response: productResult,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(productResult.body).length; i++) {
              orderList.add(Order.fromJson(
                  jsonEncode(jsonDecode(productResult.body)[i])));
            }
          });
    } catch (e) {
      debugPrint("Error : ${e.toString()}");
      showSnackBar(context, e.toString());
    }
    return orderList;
  }
}
