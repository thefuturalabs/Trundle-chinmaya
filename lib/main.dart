import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trundle/pages/customer/customer_home_page.dart';
import 'package:trundle/pages/login_page.dart';
import 'package:trundle/pages/rental_company/company_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String?> getUserType() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    // spref.setString('user_type', 'company');
    return spref.getString('user_type');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: Color.fromARGB(255, 49, 65, 156),
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: getUserType(),
        builder: (context, snap) {
          if (snap.hasData) {
            
            if (snap.data == 'customer') {
              return CustomerHomePage();
            } else if (snap.data == 'company') {
              return CompanyHomePage();
            } else {
              return LoginPage();
            }
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
