import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trundle/pages/rental_company/company_home_page.dart';
import 'package:trundle/services/services.dart';

class CompanyRegistrationPage extends StatefulWidget {
  CompanyRegistrationPage({super.key});

  @override
  State<CompanyRegistrationPage> createState() =>
      _CompanyRegistrationPageState();
}

class _CompanyRegistrationPageState extends State<CompanyRegistrationPage> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  // TextEditingController dateController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final fkey = GlobalKey<FormState>();

  File? pickedImage;

  signUp(BuildContext context) async {
    if (pickedImage != null) {
      final data = await Services.postWithIamge(
          endPoint: 'company_register.php',
          params: {
            'name': nameController.text,
            'email': emailController.text,
            'mobile': phoneController.text,
            // 'dob': dateController.text,
            'place': locationController.text,
            'username': usernameController.text,
            'password': passwordController.text,
          },
          image: pickedImage!,
          imageParameter: 'f1');

      if (data['message'] == 'registration successfull') {
        SharedPreferences spref = await SharedPreferences.getInstance();
        spref.setString('user_id', data['company_id']);
        spref.setString('user_type', 'company');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => CompanyHomePage(),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: 'Something went wrong');
      }
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
                    'SignUp',
                    style: TextStyle(
                        color: Color.fromARGB(255, 169, 200, 226),
                        fontSize: 50,
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
                  controller: usernameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter username';
                    }
                  },
                  decoration: InputDecoration(
                    label: Text('username'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter email';
                    }
                  },
                  decoration: InputDecoration(
                    label: Text('email'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: phoneController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter phone';
                    }
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    label: Text('phone'),
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
                  controller: locationController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter place';
                    }
                  },
                  // keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    label: Text('place'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter password';
                    }
                  },
                  // keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    label: Text('password'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (fkey.currentState!.validate()) {
                      if(pickedImage==null){
                        Fluttertoast.showToast(msg: 'pick image');
                      }else{
                      signUp(context);}
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text('signUp'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
