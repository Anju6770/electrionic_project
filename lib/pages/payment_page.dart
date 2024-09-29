import 'package:electrionic_project/ManageState/order_controller.dart';
import 'package:electrionic_project/data/address_list.dart';
import 'package:electrionic_project/data/payment_list.dart';
import 'package:electrionic_project/model/payment.dart';
import 'package:electrionic_project/pages/purchase_page.dart';
import 'package:electrionic_project/time_pass/Constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PaymentModel _selectedMethod = allMethods[0];
  final TextEditingController _cardNumber = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
            color: Colors.black,size: 27
        ),
        title: Text(
          "Payment Information",
          style: mystyle(28,),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: ${customer[0].name}',
                style: TextStyle(fontSize: 24,color: Colors.grey),
              ),
              Text(
                'Email: ${customer[0].email}',
                style: TextStyle(fontSize: 24,color: Colors.grey),
              ),
              Text(
                'Contact:+975-${customer[0].phoneNo}',
                style: TextStyle(fontSize: 24,color: Colors.grey),
              ),
              Text(
                'Address: ${customer[0].address}',
                style: TextStyle(fontSize: 24,color: Colors.grey),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GetBuilder<OrderController>(builder: (controller) {
                              return Text('Total: \$ ${controller.getTotalPrice().toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 24,color: Colors.grey),
                              );
                            }),
                            Gap(10),
                            Text(
                              "Choose your payment method",
                              style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                            ),
                            Gap(10),
                            Card(
                              elevation: 4,
                              child: DropdownButton<PaymentModel>(
                                value: _selectedMethod,
                                onChanged: (PaymentModel? newValue) {
                                  setState(() {
                                    _selectedMethod = newValue!;
                                  });
                                },
                                items: allMethods.map<DropdownMenuItem<PaymentModel>>(
                                      (PaymentModel card) {
                                    return DropdownMenuItem<PaymentModel>(
                                      value: card,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.1,
                                            height: MediaQuery.of(context).size.width*0.1,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("${card.imgUrl}"),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Gap(10),
                                          Text("${card.paymentMethod}"),
                                        ],
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                            Gap(10),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _cardNumber,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      hintText: 'Card number',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter card number";
                                      }
                                      return null;
                                    },
                                  ),
                                  Gap(10),
                                  TextFormField(
                                    controller: _amount,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      hintText: 'Amount',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter the amount";
                                      }
                                      return null;
                                    },
                                  ),
                                  Gap(10),
                                  TextFormField(
                                    controller: _password,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter your password";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Gap(20),
                            MaterialButton(
                              height: MediaQuery.of(context).size.height*0.055,
                              color: Colors.black,
                              minWidth: double.infinity,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.black,
                                        content: Text("Are you sure you want to proceed with the purchase?",style: TextStyle(fontSize: 20,color: Colors.white),),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Cancel",style: mystyle(17,Colors.white),),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (builder) => PurchasePage(),
                                                    ),
                                                  );
                                                },
                                                child: Text("Confirm",style: mystyle(17,Colors.white),),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: Text(
                                "Buy Now",
                                style: mystyle(20, Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}
