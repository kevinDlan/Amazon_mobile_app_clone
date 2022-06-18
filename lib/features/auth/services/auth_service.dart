import 'dart:convert';

import 'package:amazon/constants/error_handle.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/home/screens/home_screen.dart';
import 'package:amazon/models/user.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //signup
  void signupUser(
      {required String name,
      required BuildContext context,
      required String email,
      required String password}) async {
    try {
      User user = User(
          id: 'id',
          name: name,
          email: email,
          password: password,
          address: 'address',
          type: 'type',
          token: 'token');

      http.Response res = await http.post(Uri.parse('$uri/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, "Account created, Login with same credential.");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/signin'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackBar(context, "Login Successfully.");
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            await sharedPreferences.setString("x-auth-token",jsonDecode(res.body)['token'] );
            Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
          });
    } catch (e)
    {
      showSnackBar(context, e.toString());
    }
  }
}
