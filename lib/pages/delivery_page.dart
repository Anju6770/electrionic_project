import 'package:electrionic_project/ManageState/order_controller.dart';
import 'package:electrionic_project/data/address_list.dart';
import 'package:electrionic_project/model/address.dart';
import 'package:electrionic_project/time_pass/Constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
            color: Colors.black,size: 27
        ),
        title: Text(
          "Delivery Information",
          style: mystyle(27,),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: "Enter your Name",
                        suffixIcon: Icon(Icons.drive_file_rename_outline_outlined,),
                        //border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Name";
                        }
                        return null;
                      },
                    ),
                    Gap(10),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        hintText: "Enter your Location",
                        suffixIcon: Icon(Icons.location_on,),
                        //border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Address";
                        }
                        return null;
                      },
                    ),
                    Gap(10),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter your Email",
                        suffixIcon: Icon(Icons.email_outlined,),
                        //border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Email";
                        }
                        if (!value.contains("@gmail.com")) {
                          return "Email should contain gmail.com";
                        }
                        return null;
                      },
                    ),
                    Gap(10),
                    Row(
                      children: [
                        Text("+975-",style: TextStyle(fontSize: 18),),
                        Gap(5),
                        Container(
                          width: MediaQuery.of(context).size.width*0.68,
                          child: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: "Enter your Number",
                              suffixIcon: Icon(Icons.call,),
                              //border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter Phone Number";
                              }
                              if (value.length > 8) {
                                return "Password must be at least 8 characters";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GetBuilder<OrderController>(builder: (controller) {
                          return Text('Total: \$ ${controller.getTotalPrice().toStringAsFixed(2)}',
                            style: mystyle(20,Colors.black,FontWeight.bold),
                          );
                        }),
                      ],
                    ),
                    Gap(20),
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width * 0.94,
                      color: Colors.black,  height: MediaQuery.of(context).size.height*0.062,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),  onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        customer.add(
                          AddressClass(
                            name: _nameController.text.toString(),
                            address: _addressController.text.toString(),
                            email: _emailController.text.toString(),
                            phoneNo: _phoneController.text.toString(),
                          ),
                        );
                        Get.toNamed('/payment');
                      }
                    },
                      child: Text(
                        "Make Payment",
                        style: TextStyle(color: Colors.white,fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
