import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/account/widget/below_app_bar.dart';
import 'package:amazon/features/account/widget/orders.dart';
import 'package:amazon/features/account/widget/top_buttons.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

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
                child: Row(
                  children:   [
                    Padding(padding: const EdgeInsets.only(right: 15),
                    child: Badge(
                        elevation: 0,
                        badgeContent: const Text("1"),
                        child: const Icon(Icons.notifications_outlined)),
                    ),
                    const Icon(Icons.search_outlined)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: const[
          BelowAppBar(),
          SizedBox(height: 10),
          TopButtons(),
          SizedBox(height: 20),
          Orders(),
        ],
      ),
    );
  }
}
