import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:workshop_demo_app/models/paygate_request.dart';
import 'package:workshop_demo_app/models/paygate_response.dart';
import 'package:workshop_demo_app/models/shoe.dart';
import 'package:workshop_demo_app/utils/constants.dart';
import 'package:workshop_demo_app/utils/context.dart';
import 'package:workshop_demo_app/utils/int_extension.dart';
import 'package:workshop_demo_app/utils/mobile_operator.dart';
import 'package:workshop_demo_app/utils/text_formatter.dart';

const String authToken = "08b9094a-79af-48e1-9523-2eb21354d301";

class PayShoeScreen extends StatefulWidget {
  const PayShoeScreen({super.key, required this.shoe});

  final Shoe shoe;

  @override
  State<PayShoeScreen> createState() => _PayShoeScreenState();
}

class _PayShoeScreenState extends State<PayShoeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();

  bool _loading = false;

  PaygateRequest? _paygateRequest;
  PaygateResponse? _paygateResponse;

  @override
  void dispose() {
    _numberController.removeListener(_updateOperator);
    _numberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _numberController.addListener(_updateOperator);
    super.initState();
  }

  MobileOperator get operator => _numberController.text.operator;

  Future<void> pay() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _loading = true;
    });
    try {
      http.Response response = await http.post(
        Uri.parse("https://paygateglobal.com/api/v1/pay"),
        body: {
          "auth_token": authToken,
          "phone_number": "90495033", //"90495033"
          "amount": "1",
          "description": "Paiement de chaussures",
          "identifier": "shoes-1-pay-user-07",
          "network": "TMONEY"
        },
      );

      Map<String, dynamic> data = jsonDecode(response.body);

      setState(() {
        _paygateRequest = PaygateRequest.fromJson(data);
      });
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() {
      _loading = false;
    });
  }

  Future<void> verify() async {
    setState(() {
      _loading = false;
    });

    try {
      http.Response response = await http.post(
        Uri.parse("https://paygateglobal.com/api/v1/status"),
        body: {
          "auth_token": authToken.toString(),
          "tx_reference": _paygateRequest?.txRef.toString(),
        },
      );

      Map<String, dynamic> data = jsonDecode(response.body);

      setState(() {
        _paygateResponse = PaygateResponse.fromJson(data);
      });
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() {
      _loading = false;
    });
  }

  void _updateOperator() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstantsColor.materialButtonColor,
        title: const Text('Payer la chaussure'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: _numberController,
                  cursorColor: AppConstantsColor.materialButtonColor,
                  decoration: InputDecoration(
                    labelText: "Téléphone",
                    labelStyle: const TextStyle(
                      color: AppConstantsColor.materialButtonColor,
                    ),
                    hintText: "Entrez le numéro de Téléphone",
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppConstantsColor.materialButtonColor,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppConstantsColor.materialButtonColor,
                      ),
                    ),
                    suffixIcon: Image.asset(operator.asset, height: 24),
                  ),
                  style: const TextStyle(fontSize: 24),
                  inputFormatters: [PhoneNumberInputFormatter()],
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return 'Veuillez entrer un numéro de téléphone';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 50),
                _loading
                    ? const Center(child: CircularProgressIndicator())
                    : (_paygateRequest == null || _paygateRequest!.status != 0)
                        ? MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minWidth: context.width / 1.2,
                            height: context.height / 15,
                            color: Colors.pink,
                            onPressed: pay,
                            child: Text(
                              "PAYER ${widget.shoe.price.formatted}",
                              style: const TextStyle(
                                color: AppConstantsColor.lightTextColor,
                                fontSize: 24,
                              ),
                            ),
                          )
                        : MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minWidth: context.width / 1.2,
                            height: context.height / 15,
                            color: Colors.green[900],
                            onPressed: verify,
                            child: const Text(
                              "VÉRIFIER",
                              style: TextStyle(
                                color: AppConstantsColor.lightTextColor,
                                fontSize: 24,
                              ),
                            ),
                          ),
                const SizedBox(height: 50),
                const Divider(
                  height: 10,
                  thickness: 6,
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    SizedBox(
                      width: context.width * 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: const Icon(Icons.phone),
                            width: context.width * 0.1,
                          ),
                          const Text(
                            "Téléphone : ",
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _numberController.text,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: context.width * 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: const Icon(Icons.payment),
                            width: context.width * 0.1,
                          ),
                          const Text(
                            "Status : ",
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _paygateRequest == null
                          ? "Initial"
                          : _paygateResponse == null
                              ? "En attente"
                              : _paygateResponse!.status == 0
                                  ? "En vérification"
                                  : "Payé",
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
