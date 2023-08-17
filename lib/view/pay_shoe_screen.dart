import 'package:flutter/material.dart';
import 'package:flutter_paygateglobal/flutter_paygateglobal.dart';
import 'package:workshop_demo_app/models/shoe.dart';
import 'package:workshop_demo_app/utils/constants.dart';
import 'package:workshop_demo_app/utils/context.dart';
import 'package:workshop_demo_app/utils/int_extension.dart';
import 'package:workshop_demo_app/utils/mobile_operator.dart';
import 'package:workshop_demo_app/utils/paygate_extensions.dart';
import 'package:workshop_demo_app/utils/text.dart';
import 'package:workshop_demo_app/utils/text_formatter.dart';

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

  bool _openPaygatePage = false;

  NewTransactionResponse? _paygateResponse;
  Transaction? _transaction;

  @override
  void dispose() {
    _numberController.removeListener(_updateOperator);
    _numberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Paygate.init(apiKey: "08b9094a-79af-48e1-9523-2eb21354d301");
    _numberController.addListener(_updateOperator);
    super.initState();
  }

  MobileOperator get operator => _numberController.text.operator;
  String get phoneNumber => _numberController.text.replaceAll(" ", "");

  Future<void> payV1() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      _paygateResponse = await Paygate.payV1(
        //amount: widget.shoe.price.toDouble(),
        amount: 1,
        provider: operator.provider,
        description: "Paiement de chaussure ${widget.shoe.name}",
        phoneNumber: phoneNumber,
      );
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() {
      _loading = false;
    });
  }

  Future<void> payV2() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      _paygateResponse = await Paygate.payV2(
        //amount: widget.shoe.price.toDouble(),
        amount: 1,
        provider: operator.provider,
        description: "Paiement de chaussure ${widget.shoe.name}",
        phoneNumber: phoneNumber,
      );
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() {
      _loading = false;
    });
  }

  Future<void> verify() async {
    if (_paygateResponse == null) {
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      _transaction = await Paygate.verifyTransaction(
        txReference: _paygateResponse!.txReference,
      );
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
                //Switch
                const SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Ouvrir une page externe de paiement",
                        style: TextStyle(fontSize: 18),
                      ),
                      Switch(
                        activeColor: AppConstantsColor.materialButtonColor,
                        value: _openPaygatePage,
                        onChanged: (bool value) {
                          setState(() {
                            _openPaygatePage = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),

                _loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : (_paygateResponse?.ok ?? false)
                        ? (_transaction?.done ?? false)
                            ? const SizedBox.shrink()
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
                              )
                        : _openPaygatePage
                            ? MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minWidth: context.width / 1.2,
                                height: context.height / 15,
                                color: Colors.red,
                                onPressed: payV2,
                                child: Text(
                                  "PAYER V2 ${widget.shoe.price.formatted}",
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
                                color: Colors.pink,
                                onPressed: payV1,
                                child: Text(
                                  "PAYER V1 ${widget.shoe.price.formatted}",
                                  style: const TextStyle(
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
                      width: context.width * 0.45,
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
                const SizedBox(height: 20),
                if (_paygateResponse != null)
                  Row(
                    children: [
                      SizedBox(
                        width: context.width * 0.45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: const Icon(Icons.payment),
                              width: context.width * 0.1,
                            ),
                            const Text(
                              "Paiement : ",
                              style: TextStyle(fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: context.width * 0.5,
                        child: Text(
                          _paygateResponse!.status == null
                              ? "Initialisation échouée"
                              : _paygateResponse!.status!.label,
                          style: const TextStyle(fontSize: 24),
                        ).rich(
                          context,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                if (_transaction != null)
                  Row(
                    children: [
                      SizedBox(
                        width: context.width * 0.45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: const Icon(Icons.payment),
                              width: context.width * 0.1,
                            ),
                            const Text(
                              "Vérification : ",
                              style: TextStyle(fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: context.width * 0.5,
                        child: Text(
                          _transaction == null
                              ? "Initial"
                              : _transaction!.status.label,
                          style: const TextStyle(fontSize: 24),
                        ).rich(
                          context,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
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
