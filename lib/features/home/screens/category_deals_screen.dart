import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/home/services/home_services.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../../models/product.dart';

class CategoriesDealScreen extends StatefulWidget {
  final String category;
  const CategoriesDealScreen({Key? key, required this.category})
      : super(key: key);

  static const String routeName = "/category-deals";
  @override
  State<CategoriesDealScreen> createState() => _CategoriesDealScreenState();
}

class _CategoriesDealScreenState extends State<CategoriesDealScreen> {
  HomeServices homeServices = HomeServices();
  List<Product>? products = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProductCategory();
  }

  void fetchProductCategory() async {
    products = await homeServices.fetchProductCategory(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: products == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text("Keep Shopping for ${widget.category}"),
                ),
                SizedBox(
                    height: 170,
                    child: GridView.builder(
                        itemCount: products!.length,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 15),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 1.4,
                                mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          final product = products![index];
                          return Column(
                            children: [
                              SizedBox(
                                height: 130,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black12, width: 0.5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.network(product.images[0]),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(
                                  left: 0,
                                  right: 15,
                                  top: 5,
                                ),
                                child: Text(product.name, maxLines: 1, style: const TextStyle(overflow: TextOverflow.ellipsis),),
                              )
                            ],
                          );
                        })),
              ],
            ),
    );
  }
}
