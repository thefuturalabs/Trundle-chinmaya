import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trundle/pages/rental_company/company_home_page.dart';
import 'package:trundle/services/services.dart';

class EditVehicleScreen extends StatefulWidget {
  EditVehicleScreen({super.key, required this.vehicleId});
  String vehicleId;

  @override
  State<EditVehicleScreen> createState() => _CompanyRegistrationPageState();
}

class _CompanyRegistrationPageState extends State<EditVehicleScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController regNoController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController fuelController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  final fkey = GlobalKey<FormState>();

  File? pickedImage;

  editVehicle(BuildContext context) async {
    final data = await Services.postData(
      {
        'vehicle_id': widget.vehicleId,
        'name': nameController.text,
        'reg_no': regNoController.text,
        'price': priceController.text,
        'color': colorController.text,
        'fuel_type': fuelController.text,
        'type': typeController.text,
      },
      'update_vehicle_details.php',
    );
    print(data);
    if ((data as Map)['message'] == 'updated') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => CompanyHomePage(),
        ),
      );
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }


  Future<dynamic> getVehicleDetails()async{
     Map vehicleData=(await Services.postData({'vehicle_id':widget.vehicleId}, 'vehicle_view.php')).first;
     nameController.text=vehicleData['name'];
     regNoController.text=vehicleData['Reg_no'];
     priceController.text=vehicleData['price'];
     colorController.text=vehicleData['color'];
     fuelController.text=vehicleData['fuel_type'];
     typeController.text=vehicleData['type'];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVehicleDetails();
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
                    'change vehicle details',
                    style: TextStyle(
                        color: Color.fromARGB(255, 169, 200, 226),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
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
                  decoration: InputDecoration(
                    label: Text('color'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: fuelController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter fuel type';
                    }
                  },
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
                  decoration: InputDecoration(
                    label: Text('vehicle type'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (fkey.currentState!.validate()) {
                      editVehicle(context);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text('Update'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
