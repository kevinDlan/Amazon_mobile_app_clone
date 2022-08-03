import 'package:amazon/features/account/widget/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context)
  {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: "Your Orders", onPressed: (){}),
            AccountButton(text: "Turn Seller", onPressed: (){}),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(text: "Log Out", onPressed: (){}),
            AccountButton(text: "Your Wishlist", onPressed: (){}),
          ],
        )
      ],
    );
  }
}
