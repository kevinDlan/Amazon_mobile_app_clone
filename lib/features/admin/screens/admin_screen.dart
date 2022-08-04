import 'package:amazon/features/admin/screens/analytics_screen.dart';
import 'package:amazon/features/admin/screens/orders_screen.dart';
import 'package:amazon/features/admin/screens/post_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  final double _bottomBarWidth = 42.0;
  final double _bottomBarBorderWidth = 5;
  List<Widget> pages = [
    const PostScreen(),
    const AnalyticsScreen(),
    const OrdersScreen(),
  ];

  void changePage(int currentPageIndex) {
    setState(() {
      _page = currentPageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                alignment: Alignment.topLeft,
                child: Image.asset('assets/images/amazon_in.png',
                    width: 120, height: 45, color: Colors.black),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, top: 15),
                alignment: Alignment.topRight,
                child: const Text("Admin",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: changePage,
        items: [
          //POSTS
          BottomNavigationBarItem(
              icon: Container(
                width: _bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _page == 0
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor,
                          width: _bottomBarBorderWidth)),
                ),
                child: const Icon(Icons.home_outlined),
              ),
              label: ""),
          //ANALYTICS
          BottomNavigationBarItem(
              icon: Container(
                width: _bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _page == 1
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor,
                          width: _bottomBarBorderWidth)),
                ),
                child: const Icon(Icons.analytics_outlined),
              ),
              label: ""),
          //ORDERS
          BottomNavigationBarItem(
              icon: Container(
                width: _bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _page == 2
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor,
                          width: _bottomBarBorderWidth)),
                ),
                child: const Icon(Icons.all_inbox_outlined),
              ),
              label: "")
        ],
      ),
      body: pages[_page],
    );
  }
}
