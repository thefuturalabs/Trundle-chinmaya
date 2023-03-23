import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/services.dart';
import 'gpay_screen.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen(
      {super.key,
      required this.vehicleId,
      required this.customerId,
      required this.price});
  String vehicleId;
  String customerId;
  String price;
  final fkey = GlobalKey<FormState>();
  TextEditingController upiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(40),
                child: Text(
                  '₹$price',
                  style: TextStyle(fontSize: 60),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text('Pay using,'),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text('enter UPI id'),
                              content: Form(
                                key: fkey,
                                child: TextFormField(
                                  controller: upiController,
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'Enter upi';
                                    } else if (!v.contains('@')) {
                                      return "upi id format not corrent";
                                    }
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => GpayScreen(
                                          makePayment: bookVehicle,
                                        ),
                                      ),
                                    );
                                    // await launchUrl(
                                    //   Uri.parse(
                                    //     'upi://pay?pa=${upiController.text}&pn=Dev&am=$price.00&cu=INR&aid=uGICAgICNgb2BfQ',
                                    //   ),
                                    //   mode: LaunchMode
                                    //       .externalNonBrowserApplication,
                                    // );
                                    // Future.delayed(Duration(seconds: 5))
                                    //     .then((value) {
                                    //   bookVehicle();
                                    // });
                                  },
                                  child: Text('Submit'),
                                ),
                              ],
                            );
                          });
                    },
                    child: Text('upi')),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: null,
                    child: Text('Bank transfer'),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  bookVehicle() async {
    print(price);
    String uid = await Services.getUserId() ?? '2';
    final data = await Services.postData(
        {'customer_id': uid, 'vehicle_id': vehicleId,'price':price}, 'book_vehicle.php');
    if (data['result'] == 'booked') {
      Fluttertoast.showToast(msg: 'vehicle requested');
    }
  }
}
