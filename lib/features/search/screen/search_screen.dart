import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/home/widgets/address_box.dart';
import 'package:amazon/features/search/services/search_services.dart';
import 'package:amazon/features/search/widget/searched_product_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../../models/product.dart';
import '../../product_details/screens/product_details_screen.dart';

class SearchScreen extends StatefulWidget {
  final String searchQuery;
  const SearchScreen({Key? key, required this.searchQuery}) : super(key: key);
  static const String routeName = "/search-screen";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products = [];
  SearchServices searchServices = SearchServices();

  void getSearchedProducts() async {
    products = await searchServices.fetchSearchedProduct(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreen(searchQuery) {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: searchQuery);
  }

  navigateToProductDetailScreen(Product product)
  {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName, arguments: product);
  }
  double avgRating = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchedProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: GlobalVariables.appBarGradient),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 42,
                margin: const EdgeInsets.only(left: 15),
                alignment: Alignment.topLeft,
                child: Material(
                  borderRadius: BorderRadius.circular(7),
                  elevation: 1,
                  child: TextFormField(
                    onFieldSubmitted: navigateToSearchScreen,
                    decoration: InputDecoration(
                      hintText: "Search Amazon.in",
                      hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 17),
                      prefixIcon: InkWell(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Icon(Icons.search, color: Colors.black),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.only(top: 10),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide.none),
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide:
                              BorderSide(color: Colors.black38, width: 1)),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              height: 42,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: const Icon(Icons.mic, color: Colors.black12, size: 25),
            )
          ],
        ),
      ),
      body: products == null
          ? const Loader()
          : Column(
              children: [
                const AddressBox(),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: products!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: ()
                              {
                                navigateToProductDetailScreen(products![index]);
                              },
                              child: SearchedProductWidget(
                                  product: products![index]));
                        }))
              ],
            ),
    );
  }
}
