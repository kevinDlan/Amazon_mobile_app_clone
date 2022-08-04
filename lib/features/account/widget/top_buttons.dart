import 'package:amazon/features/account/services/account_service.dart';
import 'package:amazon/features/account/widget/account_button.dart';
import 'package:amazon/features/auth/screens/auth_screen.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: "Your Orders", onPressed: () {}),
            AccountButton(text: "Turn Seller", onPressed: () {}),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
                text: "Log Out",
                onPressed: () => AccountService().logOut(context, () {
                      // if (!mounted) return;
                      Navigator.pushNamedAndRemoveUntil(
                          context, AuthScreen.routeName, (route) => false);
                    })),
            AccountButton(text: "Your Wishlist", onPressed: () {}),
          ],
        )
      ],
    );
  }
}
