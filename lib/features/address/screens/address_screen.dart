import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textfield.dart';
import '../../../constants/global_variables.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);
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

  void onGooglePayResult(res) {}
  void onApplePayResult(res) {}
  @override
  Widget build(BuildContext context) {
    //var address = context.watch<UserProvider>().user.address;
    var address = "Abidjan-Cocody-Riviera Golf";
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
              ApplePayButton
                (
                  width: double.infinity ,
                  style: ApplePayButtonStyle.whiteOutline,
                  type: ApplePayButtonType.buy,
                  paymentConfigurationAsset: "applepay.json",
                  onPaymentResult: onApplePayResult,
                  paymentItems: paymentItem,
                  margin: const EdgeInsets.only(top: 15),
              ),
              const SizedBox(height: 10),
              GooglePayButton(
                  width: double.infinity,
                  style: GooglePayButtonStyle.black,
                  type: GooglePayButtonType.buy,
                  paymentConfigurationAsset: "gpay.json",
                  onPaymentResult: onGooglePayResult,
                  paymentItems: paymentItem,
                  margin: const EdgeInsets.only(top: 15),
                loadingIndicator: const Center(child: CircularProgressIndicator(),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
