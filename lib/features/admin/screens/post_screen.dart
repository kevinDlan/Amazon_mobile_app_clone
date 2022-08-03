import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/account/widget/single_product.dart';
import 'package:amazon/features/admin/screens/add_product_screen.dart';
import 'package:amazon/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Product>? products;
  final AdminService adminService = AdminService();

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllProduct();
  }

  void fetchAllProduct() async
  {
    products = await adminService.getAllProduct(context:context);
    setState(() {});
  }
  
  void deleteProduct(Product product, int index)
  {
    adminService.deleteProduct(context: context, product: product, onSuccess: ()
    {
        products!.removeAt(index);
        setState((){});
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: products!.isNotEmpty
                ? GridView.builder(
                    itemCount: products!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      final productData = products![index];
                      return Column(
                        children: [
                          SizedBox(
                            height: 130,
                            child: SingleProduct(
                              imageLink: productData.images[0],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 10),
                            child:Row(
                              children: [
                                Expanded(
                                    child: Text(productData.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontWeight: FontWeight.w600),
                                        maxLines: 2)),
                                 IconButton(
                                    onPressed: () => deleteProduct(productData, index),
                                    icon: const Icon(
                                      Icons.delete_outline,
                                    ))
                              ],
                            ),
                          )
                        ],
                      );
                    })
                : const Center(
                    child: Text(
                      'Not Product added yet',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: navigateToAddProduct,
              tooltip: "Add new Product",
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
