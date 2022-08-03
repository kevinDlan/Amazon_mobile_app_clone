import 'dart:convert';
import 'package:amazon/models/product.dart';
import 'package:amazon/models/user.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/error_handle.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';


class CartService
{

  void removeFromCart({required BuildContext context, required Product product}) async
  {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response resp = await http.delete(
        Uri.parse('$uri/remove-from-cart/${product.id}'),
        headers:
        {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        }
      );
      httErrorHandle(
          context: context,
          response: resp,
          onSuccess: () {
            User user = userProvider.user.copyWith(cart:jsonDecode(resp.body)['cart']);
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }

  }

}