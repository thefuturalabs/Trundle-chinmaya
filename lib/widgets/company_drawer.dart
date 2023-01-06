import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trundle/pages/customer/customer_profile_page.dart';
import 'package:trundle/pages/login_page.dart';
import 'package:trundle/pages/rental_company/company_profile_page.dart';
import 'package:trundle/pages/rental_company/view_comapany_services.dart';
import 'package:trundle/pages/rental_company/view_company_vehicles.dart';
import 'package:trundle/pages/rental_company/view_service_requests.dart';
import 'package:trundle/pages/view_feedbacks.dart';

class CompanyDrawer extends StatelessWidget {
  const CompanyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 60,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CompanyProfilePage(),
                      ),
                    );
                  },
                  child: Text(
                    'Manage Profile',
                    style: TextStyle(fontSize: 30),
                  ),
                )),
            Divider(),
            Card(
              child: ListTile(
                onTap: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ViewCompanyVehicles(),
                    ),
                  );
                },
                title: Text('My vehicles'),
                trailing: Icon(Icons.commute),
              ),
            ),
             Card(
              child: ListTile(
                onTap: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ViewServiceRequests(),
                    ),
                  );
                },
                title: Text('Service Requests'),
                trailing: Icon(Icons.manage_history),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ViewCompanyServices(),
                    ),
                  );
                },
                title: Text('My Services'),
                trailing: Icon(Icons.construction),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ViewFeedbacksPage(),
                    ),
                  );
                },
                title: Text('Feedbacks'),
                trailing: Icon(Icons.feedback),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () async {
                  SharedPreferences.getInstance().then(
                    (value) => value.clear(),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginPage(),
                    ),
                  );
                },
                title: Text('Logout'),
                trailing: Icon(Icons.logout),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
