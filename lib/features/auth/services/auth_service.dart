import 'package:amazon/constants/error_handle.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
            'Content-Type': 'application/json, charset=UTF-8',
            // 'Accept':'application/json'
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
}
