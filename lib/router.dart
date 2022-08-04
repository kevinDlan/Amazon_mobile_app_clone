import 'package:amazon/features/address/screens/address_screen.dart';
import 'package:amazon/features/admin/screens/add_product_screen.dart';
import 'package:amazon/features/auth/screens/auth_screen.dart';
import 'package:amazon/features/home/screens/category_deals_screen.dart';
import 'package:amazon/features/home/screens/home_screen.dart';
import 'package:amazon/features/order_details/screens/order_details.dart';
import 'package:amazon/features/product_details/screens/product_details_screen.dart';
import 'package:amazon/features/search/screen/search_screen.dart';
import 'package:amazon/models/order.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';

import 'common/widgets/bottom_bar.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProductScreen());
    case CategoriesDealScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoriesDealScreen(category: category));
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(searchQuery: searchQuery));
    case ProductDetailsScreen.routeName:
      Product product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailsScreen(product: product));
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => AddressScreen(totalAmount: totalAmount));
    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => OrderDetailsScreen(order: order));
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Screen does not exit !'),
                ),
              ));
  }
}
