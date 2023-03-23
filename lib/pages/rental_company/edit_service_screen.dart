import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trundle/services/services.dart';

class EditServiceScreen extends StatefulWidget {
  EditServiceScreen({super.key, required this.serviceId});
  String serviceId;

  @override
  State<EditServiceScreen> createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends State<EditServiceScreen> {
  final fkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

// TextEditingController typeController=TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController placeController = TextEditingController();

  String? serviceType;

  List<String> services = [
    'battery service',
    'puncture',
    'tyre change',
    'tow',
    'fuel refill',
    'oil change',
    'brake service'
  ];

  updateService(BuildContext context) async {
    final data = await Services.postData(
      {
        'service_id': widget.serviceId,
        'name': nameController.text,
        'type': serviceType,
        'phone': phoneController.text,
        'location': placeController.text
      },
      'update_service.php',
    );
    if (data['message'] == 'updated') {
      Fluttertoast.showToast(msg: 'service updated');

      Future.delayed(Duration(seconds: 1)).then((value) {
        Fluttertoast.cancel();
        Fluttertoast.showToast(msg: 'pull down to refresh');
      });
      Navigator.pop(context);
    }
  }

  getServiceDetails() async {
    Map serviceDetails = (await Services.postData({
      'service_id': widget.serviceId,
    }, 'view_service.php'))
        .first;
    nameController.text = serviceDetails['name'];
    phoneController.text = serviceDetails['mobile'];
    placeController.text = serviceDetails['place'];
    setState(() {
      serviceType = serviceDetails['type'];
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getServiceDetails();
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
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) {
                      serviceType = v;
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
                      print(
                          '${fkey.currentState!.validate()} and ${serviceType != null}');
                      if (fkey.currentState!.validate()) {
                        if (serviceType == null) {
                          Fluttertoast.showToast(msg: 'select type');
                        } else {
                          updateService(context);
                        }
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
