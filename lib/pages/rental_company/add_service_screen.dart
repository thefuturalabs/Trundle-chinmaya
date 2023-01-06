import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trundle/services/services.dart';

class AddServiceScreen extends StatelessWidget {
  AddServiceScreen({super.key});

  final fkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
// TextEditingController typeController=TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  String? serviceType;

  List<String> services = [
    'battery service'
        'puncture',
    'tyre change',
    'tow',
    'fuel refill'
        'oil change',
    'brake service'
  ];

  addService(BuildContext context) async {
    String uid = await Services.getUserId() ?? '2';
    final data=await Services.postData(
      {
        'name': nameController.text,
        'company_id': uid,
        'type': serviceType,
        'mobile': phoneController.text,
        'place': placeController.text
      },
      'add_service.php',
    );
    if(data['msg']=='done'){
      Fluttertoast.showToast(msg: 'service added');
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
            child: Column(
              children: [
                
                Padding(
                  padding: EdgeInsets.only(
                      top: height / 5, bottom: 10, left: 10, right: 10),
                  child: const Text(
                    'add your services',
                    style: TextStyle(
                        color: Color.fromARGB(255, 169, 200, 226),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        label: Text('service type'),
                        border: OutlineInputBorder(),
                      ),
                    items: services
                        .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e)))
                        .toList(),
                    onChanged: (v) {
                      serviceType=v;
                    },
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
                    controller: placeController,
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
                ElevatedButton(
                    onPressed: () {
                      print('${fkey.currentState!.validate()} and ${serviceType != null}');
                      if (fkey.currentState!.validate() ) {
                        if(serviceType==null){
                          Fluttertoast.showToast(msg: 'select type');
                        }else{
                        addService(context);}
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('update'),
                    )),
              ],
            )),
      ),
    );
  }
}
