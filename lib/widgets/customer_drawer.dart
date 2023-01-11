import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trundle/pages/customer/booked_vehicles_screen.dart';
import 'package:trundle/pages/customer/customer_profile_page.dart';
import 'package:trundle/pages/customer/view_services.dart';
import 'package:trundle/pages/login_page.dart';
import 'package:trundle/pages/view_feedbacks.dart';

import '../pages/customer/add_feedback_page.dart';

class CustomerDrawer extends StatelessWidget {
  const CustomerDrawer({super.key});

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
                        builder: (_) => CustomerProfilePage(),
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
                        builder: (_) => BookedVehicles(),
                      ),
                    );
                },
                title: Text('History'),
                trailing: Icon(Icons.history),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ViewServices(),
                      ),
                    );
                },
                title: Text('Services'),
                trailing: Icon(Icons.history),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ViewFeedbacksPage(addFeedback: true),
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
