import 'dart:convert';
import 'package:amazon/constants/error_handle.dart';
import 'package:amazon/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/global_variables.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';

class AddressService
{
  void saveUserAddress({
    required BuildContext context,
    required String address}) async
  {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try
        {
          http.Response response = await http.post(
            Uri.parse('$uri/save-user-address'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': userProvider.user.token
            },
            body: jsonEncode({
              "address":address
            }),
          );

          httErrorHandle(response: response, context: context, onSuccess: ()
          {
            User user = userProvider.user.copyWith(
                address: jsonDecode(response.body)["address"]
            );
            userProvider.setUserFromModel(user);
          });
        }
        catch(error)
        {
          showSnackBar(context, error.toString());
        }
  }

  void makeOrder({
  required BuildContext context,
  required String address,
  required double totalSum,
}) async
  {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try
    {
       http.Response res = await http.post(Uri.parse("$uri/order"),
          headers: {
            "Content-type":"application/json; charset=UTF-8",
            "x-auth-token":userProvider.user.token,
          },
         body: jsonEncode({
           "address":address,
           "totalPrice":totalSum,
           "cart":userProvider.user.cart
         })
      );

       httErrorHandle(response: res, context: context, onSuccess: ()
       {
         showSnackBar(context, "Your Order has been placed !");
         User user = userProvider.user.copyWith(cart: []);
         userProvider.setUserFromModel(user);
       });
    }
    catch(error)
    {
      showSnackBar(context, error.toString());
    }

  }
}