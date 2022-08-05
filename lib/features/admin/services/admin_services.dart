import 'dart:convert';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/admin/models/sales.dart';
import 'package:amazon/models/order.dart';
import 'package:amazon/models/product.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../constants/error_handle.dart';

class AdminService {
  void sellProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required double quantity,
      required String category,
      required List<File> images}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final cloudinary = CloudinaryPublic("big-dream-tech", "owum7xwr");
      List<String> imagesUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imagesUrls.add(res.secureUrl);
      }

      Product product = Product(
          name: name,
          description: description,
          price: price,
          quantity: quantity,
          category: category,
          images: imagesUrls);
      http.Response resp = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: product.toJson(),
      );
      httErrorHandle(
          context: context,
          response: resp,
          onSuccess: () {
            showSnackBar(context, "Product Added successfully");
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get all products
  Future<List<Product>> getAllProduct({required BuildContext context}) async {
    List<Product> products = [];
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response productResult =
          await http.get(Uri.parse("$uri/admin/get-products"), headers: {
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

  //delete product
  void deleteProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res =
          await http.post(Uri.parse("$uri/admin/delete-product"),
              headers: {
                "Content-Type": "application/json; charset=UTF-8",
                "x-auth-token": userProvider.user.token
              },
              body: jsonEncode({"product_id": product.id}));

      httErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
            showSnackBar(context, "Product deleted successfully");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //fetch all orders
  Future<List<Order>> getAllOrders(BuildContext context) async {
    List<Order> orders = [];
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response ordersResult =
          await http.get(Uri.parse("$uri/admin/get-orders"), headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "x-auth-token": userProvider.user.token
      });

      httErrorHandle(
          response: ordersResult,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(ordersResult.body).length; i++) {
              orders.add(
                  Order.fromJson(jsonEncode(jsonDecode(ordersResult.body)[i])));
            }
          });
    } catch (error) {
      showSnackBar(context, error.toString());
    }

    return orders;
  }

  void updateOrderStatus(
      {required BuildContext context,
      required Order order,
      required int status,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res =
          await http.post(Uri.parse("$uri/admin/update-order-status"),
              headers: {
                "Content-Type": "application/json; charset=UTF-8",
                "x-auth-token": userProvider.user.token
              },
              body: jsonEncode({"id": order.id, "status": status}));

      httErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
            showSnackBar(context, "Order Status update successfully");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> fetchEarning(BuildContext context) async {
    List<Sales> sales = [];
    int totalEarning = 0;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.get(Uri.parse("$uri/analytics"), headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "x-auth-token": userProvider.user.token
      });
      httErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            var data = jsonDecode(res.body);
            totalEarning = data['totalEarning'];
            sales = [
              Sales("Mobiles", data['mobileEarning']),
              Sales("Essentials", data['essentialsEarning']),
              Sales("Appliances", data['appliancesEarning']),
              Sales("Books", data['booksEarning']),
              Sales("Fashion", data['fashionEarning']),
            ];
          });
    } catch (e)
    {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
    return {'sales': sales, 'totalEarning': totalEarning};
  }
}
