import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/address/services/address_services.dart';
import 'package:amazon/models/user.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/custom_textfield.dart';
import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';

class AddressScreen extends StatefulWidget {
  final String totalAmount;
  const AddressScreen({Key? key, required this.totalAmount}) : super(key: key);
  static const String routeName = "/address";
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressConfigFormKey = GlobalKey<FormState>();
  final TextEditingController addressFlatNoController = TextEditingController();
  final TextEditingController addressAreaStreetController =
      TextEditingController();
  final TextEditingController addressPinCodeController =
      TextEditingController();
  final TextEditingController addressTownCityController =
      TextEditingController();
  final AddressService addressService = AddressService();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addressAreaStreetController.dispose();
    addressAreaStreetController.dispose();
    addressPinCodeController.dispose();
    addressTownCityController.dispose();
  }

  List<PaymentItem> paymentItem = [];
  String usedAddress = "";

  void onGooglePayResult(res) {}
  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context).user.address.isEmpty) {
      addressService.saveUserAddress(context: context, address: usedAddress);
    }
  }

  void handlePayButtonPressed(String addressFromProvider) {
    usedAddress = "";
    bool isValidForm = addressAreaStreetController.text.isNotEmpty ||
        addressAreaStreetController.text.isNotEmpty ||
        addressPinCodeController.text.isNotEmpty ||
        addressTownCityController.text.isNotEmpty;
    if (isValidForm) {
      if (_addressConfigFormKey.currentState!.validate()) {
        usedAddress =
            "${addressAreaStreetController.text} ,${addressAreaStreetController.text},${addressTownCityController.text} - ${addressPinCodeController.text}";
      } else {
        throw Exception("Please fill all form");
      }
    } else if (addressFromProvider.isNotEmpty) {
      usedAddress = addressFromProvider;
    } else {
      showSnackBar(context, "Error");
    }

    print(usedAddress);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    paymentItem.add(PaymentItem(
        amount: widget.totalAmount,
        label: "Total Amount",
        status: PaymentItemStatus.final_price));
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "OR",
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              Form(
                key: _addressConfigFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      CustomTextField(
                          controller: addressFlatNoController,
                          hint: "Flat, House no, Building"),
                      const SizedBox(height: 10),
                      CustomTextField(
                          controller: addressAreaStreetController,
                          hint: "Area Street",
                          maxLine: 7),
                      const SizedBox(height: 10),
                      CustomTextField(
                          controller: addressPinCodeController,
                          hint: "Pin code"),
                      const SizedBox(height: 10),
                      CustomTextField(
                          controller: addressTownCityController,
                          hint: "Town/City"),
                    ],
                  ),
                ),
              ),
              ApplePayButton(
                onPressed: () => handlePayButtonPressed(address),
                width: double.infinity,
                style: ApplePayButtonStyle.whiteOutline,
                type: ApplePayButtonType.buy,
                paymentConfigurationAsset: "applepay.json",
                onPaymentResult: onApplePayResult,
                paymentItems: paymentItem,
                margin: const EdgeInsets.only(top: 15),
              ),
              const SizedBox(height: 10),
              GooglePayButton(
                onPressed: () => handlePayButtonPressed(address),
                width: double.infinity,
                style: GooglePayButtonStyle.black,
                type: GooglePayButtonType.buy,
                paymentConfigurationAsset: "gpay.json",
                onPaymentResult: onGooglePayResult,
                paymentItems: paymentItem,
                margin: const EdgeInsets.only(top: 15),
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              CustomButton(
                  value: "Pay with Wave",
                  onTap: () => addressService.makeOrder(
                      context: context,
                      address: address,
                      totalSum: double.parse(widget.totalAmount)))
            ],
          ),
        ),
      ),
    );
  }
}
