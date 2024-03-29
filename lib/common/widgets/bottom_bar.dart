import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/account/screens/account_screen.dart';
import 'package:amazon/features/cart/screens/cart_screen.dart';
import 'package:amazon/features/home/screens/home_screen.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);
   static const String routeName = "/actual-home";
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  int _page = 0;
  final double _bottomBarWidth = 42.0;
  final double _bottomBarBorderWidth = 5;
  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

   void changePage(int currentPageIndex)
  {
    setState((){
      _page = currentPageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLength = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
    currentIndex: _page,
    selectedItemColor: GlobalVariables.selectedNavBarColor,
    unselectedItemColor: GlobalVariables.unselectedNavBarColor,
    backgroundColor: GlobalVariables.backgroundColor,
    iconSize: 28,
    onTap: changePage,
    items: [
      //Home
      BottomNavigationBarItem(icon: Container(
        width: _bottomBarWidth,
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: _page == 0
                  ? GlobalVariables.selectedNavBarColor
                  : GlobalVariables.backgroundColor,
                width: _bottomBarBorderWidth
              )
          ),
        ),
        child: const Icon(Icons.home_outlined),
      ),
        label: ""
      ),
      //Account
      BottomNavigationBarItem(icon: Container(
        width: _bottomBarWidth,
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: _page == 1
                  ? GlobalVariables.selectedNavBarColor
                  : GlobalVariables.backgroundColor,
                  width: _bottomBarBorderWidth
              )
          ),
        ),
        child: const Icon(Icons.person_outlined),
      ),
          label: ""
      ),
      //Cart
      BottomNavigationBarItem(icon: Container(
        width: _bottomBarWidth,
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: _page == 2
                  ? GlobalVariables.selectedNavBarColor
                  : GlobalVariables.backgroundColor,
                  width: _bottomBarBorderWidth
              )
          ),
        ),
        child: Badge(
            elevation: 0,
            badgeContent: Text(userCartLength.toString()),
            child: const Icon(Icons.shopping_cart_outlined)),
      ),
          label: ""
      ),
    ],
      ),
    );
  }
}
