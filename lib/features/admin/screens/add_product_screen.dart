import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_textfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);
  static const String routeName = "/add-product";

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productDescriptionController = TextEditingController();
  final TextEditingController productQuantityController = TextEditingController();
  String selectedCategory = "Mobiles";
  List<String> productCategories = ["Mobiles","Essentials","Appliances","Books","Fashion"];

  @override
  void dispose() {
    // TODO: implement dispose
    productDescriptionController.dispose();
    productNameController.dispose();
    productPriceController.dispose();
    productQuantityController.dispose();
    super.dispose();
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
          title: const Text("Add Product", style: TextStyle(color: Colors.black),),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 20),
                DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  dashPattern: const [10,4],
                  strokeCap: StrokeCap.round,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.folder_open, size: 40),
                        const SizedBox(height: 15),
                        Text("Select Product Image",
                        style: TextStyle(fontSize: 15, color: Colors.grey.shade400))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextField(controller: productNameController, hint: "Product Name"),
                const SizedBox(height: 10),
                CustomTextField(controller: productDescriptionController, hint: "Description",maxLine: 7),
                const SizedBox(height: 10),
                CustomTextField(controller: productPriceController, hint: "Price"),
                const SizedBox(height: 10),
                CustomTextField(controller: productQuantityController, hint: "Quantity"),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: selectedCategory,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String cat){
                      return DropdownMenuItem(value: cat,child: Text(cat));
                    }).toList(),
                    onChanged: (String? selectedCat)
                    {
                       setState((){
                         selectedCategory = selectedCat!;
                       });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(value: "Sell", ontap: (){})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
