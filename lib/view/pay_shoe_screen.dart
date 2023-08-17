import 'package:flutter/material.dart';
import 'package:workshop_demo_app/models/shoe.dart';
import 'package:workshop_demo_app/utils/constants.dart';
import 'package:workshop_demo_app/utils/context.dart';
import 'package:workshop_demo_app/utils/int_extension.dart';
import 'package:workshop_demo_app/utils/mobile_operator.dart';
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
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minWidth: context.width / 1.2,
                  height: context.height / 15,
                  color: Colors.pink,
                  onPressed: () {},
                  child: Text(
                    "PAYER ${widget.shoe.price.formatted}",
                    style: const TextStyle(
                      color: AppConstantsColor.lightTextColor,
                      fontSize: 24,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
