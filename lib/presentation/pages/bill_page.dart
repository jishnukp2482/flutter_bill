import 'package:flutter/material.dart';
import 'package:flutter_bill/presentation/themes/app_colors.dart';
import 'package:flutter_bill/presentation/widgets/custom/custom_print.dart';
import 'package:flutter_bill/presentation/widgets/custom/custom_text_Filed.dart';
import 'package:flutter_bill/presentation/widgets/custom/custome_gradient_widget.dart';
import 'package:flutter_bill/presentation/widgets/custom/custome_label_text_field.dart';
import 'package:flutter_bill/presentation/widgets/custom/custome_snackbar.dart';
import 'package:flutter_bill/presentation/widgets/custom/cutome_label_dropdown.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({super.key});

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  final TextEditingController billAmountController = TextEditingController();

  double tipPercentage = 0;
  String selectedTip = "15%";
  double totalAmount = 0.0;
  bool isShowTotal = false;
  void calculateTotal() {
    isShowTotal = false;
    final double billAmount = double.tryParse(billAmountController.text) ?? 0.0;
    final double tipAmount = billAmount * (tipPercentage / 100);
    warningPrint("billing amount=$billAmount");
    warningPrint("tip amount=$tipAmount");
    setState(() {
      totalAmount = billAmount + tipAmount;
    });
    customPrint("total amount=$totalAmount");
    isShowTotal = true;
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundcolor,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: AppColors.black,
            )),
        title: const Text(
          "Billing",
          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(w * 0.05),
        children: [
          SizedBox(
            height: h * 0.04,
          ),
          LabelCustomTextField(
            textFieldLabel: "Bill Amount",
            hintText: "Enter Total Bill Amount",
            inputType: TextInputType.number,
            controller: billAmountController,
            onchanged: (value) {
              setState(() {
                isShowTotal = false;
              });
            },
          ),
          SizedBox(
            height: h * 0.02,
          ),
          LabelWithDropDownField<String>(
            hintStyle: GoogleFonts.poppins(color:selectedTip.isEmpty ?  AppColors.grey:AppColors.black, fontSize: 14),
            labelStyle:GoogleFonts.poppins(color:selectedTip.isEmpty ?  AppColors.grey:AppColors.black, fontSize: 14),
            textDropDownLabel: "Tip",
            hintText: selectedTip.isEmpty ? "select Tip" : selectedTip,
            labelText: selectedTip.isEmpty ? "select Tip" : selectedTip,
            items: (p0, p1) => ["15%", "20%", "25%", "30%", "35%"],
            onChanged: (value) {
              debugPrint("value");
              warningPrint("value=$value");
              setState(() {
                isShowTotal = false;
                selectedTip = value;
                alertPrint("selectedTip=$selectedTip");
                String selectedValue = selectedTip.replaceAll("%", "");
                alertPrint("selectedvalue=$selectedValue");
                tipPercentage = double.parse(selectedValue);
              });
            },
          ),
          SizedBox(
            height: h * 0.05,
          ),
          CustomGradientButton(
              buttonBColor: AppColors.darkOrange,
              buttonTColor: AppColors.darkOrange,
              title: "calculate",
              onPressed: () {
                if (billAmountController.text.isEmpty) {
                  bottomMsg("failed", "please enter bill", false);
                } else if (selectedTip.isEmpty) {
                  bottomMsg("failed", "please select tip", false);
                } else {
                  calculateTotal();
                }
              }),
          SizedBox(
            height: h * 0.02,
          ),
          isShowTotal == true
              ? Text(
                  textAlign: TextAlign.center,
                  'Total Amount: ₹${totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: w * 0.05),
                )
              : const SizedBox.shrink()
        ],
      ),
    ));
  }
}
