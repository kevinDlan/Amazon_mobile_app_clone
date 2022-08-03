import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/home/services/home_services.dart';
import 'package:amazon/features/product_details/screens/product_details_screen.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  final HomeServices homeServices = HomeServices();
  Product? product;

  void getDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: product);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDealOfDay();
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigateToDetailScreen,
              child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: const Text(
                        "Deal of the day",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15, top: 4, right: 40),
                      child: const Text("\$100", style: TextStyle(fontSize: 18)),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15, top: 4, right: 40),
                      child: const Text(
                        "Kevin KONE",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: product!.images
                              .map((imgLink) => Image.network(imgLink,
                                  fit: BoxFit.fitWidth, width: 100, height: 100))
                              .toList()),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15)
                          .copyWith(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text("See ALL",
                          style: TextStyle(color: Colors.cyan[800])),
                    )
                  ],
                ),
            );
  }
}
