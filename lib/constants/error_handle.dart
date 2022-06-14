import 'dart:convert';
import 'package:amazon/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void httErrorHandle(
    {required http.Response response,
    required BuildContext context,
    required VoidCallback onSuccess}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
  }
}
