import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trundle/pages/rental_company/company_home_page.dart';
import 'package:trundle/services/services.dart';

class AddVehicleSceen extends StatefulWidget {
  AddVehicleSceen({super.key});

  @override
  State<AddVehicleSceen> createState() =>
      _CompanyRegistrationPageState();
}

class _CompanyRegistrationPageState extends State<AddVehicleSceen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController regNoController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController fuelController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  final fkey = GlobalKey<FormState>();

  File? pickedImage;

  addVehicle(BuildContext context) async {
    if (pickedImage != null) {
      String uid=await Services.getUserId()??'2';
      final data = await Services.postWithIamge(
          endPoint: 'add_vehicle.php',
          params: {
            'company_id':uid,
            'name': nameController.text,
            'reg_no':regNoController.text,
            'price':priceController.text,
            'color':colorController.text,
            'fuel_type':fuelController.text,
            'type':typeController.text,
          },
          image: pickedImage!,
          imageParameter: 'f1');
print(data);
      if ((data as Map) ['result'] == 'done') {
        
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => CompanyHomePage(),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
    }else{
      Fluttertoast.showToast(msg: 'Pick image first');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: fkey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: height / 5, bottom: 10, left: 10, right: 10),
                  child: const Text(
                    'enter vehicle details',
                    style: TextStyle(
                        color: Color.fromARGB(255, 169, 200, 226),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 20),
                  child: InkWell(
                    onTap: () async {
                      File? temp = await Services.pickImage(context);
                      setState(() {
                        pickedImage = temp;
                      });
                      print(pickedImage!.path);
                    },
                    child: CircleAvatar(
                      backgroundImage: pickedImage == null
                          ? AssetImage('assets/avatar.webp')
                          : FileImage(pickedImage!) as ImageProvider,
                      radius: 70,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter name';
                    }
                  },
                  decoration: InputDecoration(
                    label: Text('name'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: regNoController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter registration Number';
                    }
                  },
                  decoration: InputDecoration(
                    label: Text('registration number'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: priceController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter price';
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text('price'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: colorController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter color';
                    }
                  },
                  // keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    label: Text('color'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextFormField(
              //     controller: dateController,
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return 'enter DOB';
              //       }
              //     },
              //     decoration: InputDecoration(
              //       hintText: 'dd/mm/yyyy',
              //       suffixIcon: IconButton(
              //         onPressed: () async {
              //           dateController.text =
              //               '${await Services.getDate(context)}';
              //         },
              //         icon: Icon(Icons.calendar_month),
              //       ),
              //       label: Text('D.O.B'),
              //       border: OutlineInputBorder(),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: fuelController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter fuel type';
                    }
                  },
                  // keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    label: Text('fuel type'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: typeController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter vehicle type';
                    }
                  },
                  // keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    label: Text('vehicle type'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (fkey.currentState!.validate()) {
                      addVehicle(context);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text('addVehicle'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
