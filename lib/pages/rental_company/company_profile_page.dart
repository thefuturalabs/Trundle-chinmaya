import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/services.dart';

class CompanyProfilePage extends StatelessWidget {
  CompanyProfilePage({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  // TextEditingController dateController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  final fkey = GlobalKey<FormState>();

  String uid = '';

  Future<void> getProfileData() async {
    uid = await Services.getUserId() ?? '2';
    final data =await
        Services.postData({'company_id': uid}, 'view_company_profile.php');
        if(data!=null){
          nameController.text=data['name'];
          emailController.text=data['email'];
          phoneController.text=data['mobile'];
          // dateController.text=data['dob'];
          locationController.text=data['place'];
        }
        // return data;
  }

  updateProfile(BuildContext context) async {
  final data=await  Services.postData({
      'company_id': uid,
      'name': nameController.text,
      'email':emailController.text,
      'phn_no':phoneController.text,
      // 'dob':dateController.text,
      'place':locationController.text,
    }, 'company_profile_update.php');
    print(data);
    if(data['message']=='updated'){
      Fluttertoast.showToast(msg: 'updated');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: fkey,
          child: FutureBuilder(
              future: getProfileData(),
              builder: (context, snap) {
                if (snap.connectionState==ConnectionState.done) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: height / 5, bottom: 10, left: 10, right: 10),
                        child: const Text(
                          'Edit your profile',
                          style: TextStyle(
                              color: Color.fromARGB(255, 169, 200, 226),
                              fontSize: 30,
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
                              return 'enter location';
                            }
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            label: Text('location'),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (fkey.currentState!.validate()) {
                              updateProfile(context);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text('update'),
                          )),
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }
}
