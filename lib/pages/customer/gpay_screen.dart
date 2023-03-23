import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GpayScreen extends StatefulWidget {
  GpayScreen({super.key, required this.makePayment});
  Function makePayment;
  @override
  State<GpayScreen> createState() => _GpayScreenState();
}

class _GpayScreenState extends State<GpayScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 1800)).then((value) {
      widget.makePayment();
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 51, 51, 51),
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: Lottie.asset(
            'assets/gpay.json',
          ),
        ),
      ),
    );
  }
}
