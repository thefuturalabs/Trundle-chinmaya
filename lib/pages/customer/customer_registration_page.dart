import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trundle/pages/customer/customer_home_page.dart';
import 'package:trundle/services/services.dart';

class CustomerRegistrationPage extends StatefulWidget {
  CustomerRegistrationPage({super.key});

  @override
  State<CustomerRegistrationPage> createState() =>
      _CustomerRegistrationPageState();
}

class _CustomerRegistrationPageState extends State<CustomerRegistrationPage> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final fkey = GlobalKey<FormState>();

  signUp(BuildContext context) async {if(image!=null){
    final data = await Services.postWithIamge(
      imageParameter: 'license',
      image: image!,
      params: 
      {
        'name': nameController.text,
        'email': emailController.text,
        'phn_no': phoneController.text,
        'dob': dateController.text,
        'place': locationController.text,
        'username': usernameController.text,
        'password': passwordController.text,
      },
    endPoint:   'cus_register.php',
    );
    if (data['message'] == 'registration successfull') {
      SharedPreferences spref = await SharedPreferences.getInstance();
      spref.setString('user_id', data['user_id']);
      spref.setString('user_type', 'customer');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => CustomerHomePage(),
        ),
      );
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong');
    }}else{
      Fluttertoast.showToast(msg: 'Pick license image');
    }
  }

  File? image;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: fkey,
          child: Column(
            children: [
              Padding(
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: dateController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter DOB';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'dd/mm/yyyy',
                    suffixIcon: IconButton(
                      onPressed: () async {
                        dateController.text =
                            '${await Services.getDate(context)}';
                      },
                      icon: Icon(Icons.calendar_month),
                    ),
                    label: Text('D.O.B'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: locationController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter location';
                    }
                  },
                  // keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    label: Text('location'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Services.pickImage(context).then((value) {
                          setState(() {
                            image = value;
                          });
                        });
                      },
                      icon: Icon(Icons.photo)),
                  if (image != null)
                    SizedBox(
                        height: 50, width: 50, child: Image.file(image!)),
                  if (image != null) Expanded(child: Text('''${image!.path}''')),
                  if (image == null)
                    const Text('No image selected',
                        style: TextStyle(fontStyle: FontStyle.italic)),
                ],
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
                      signUp(context);
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
