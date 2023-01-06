import 'package:flutter/material.dart';
import 'package:trundle/pages/rental_company/add_service_screen.dart';
import 'package:trundle/services/services.dart';

class ViewCompanyServices extends StatefulWidget {
  const ViewCompanyServices({super.key});

  @override
  State<ViewCompanyServices> createState() => _ViewCompanyVehiclesState();
}

class _ViewCompanyVehiclesState extends State<ViewCompanyServices> {
  Future<dynamic> getCompanyServices() async {
    String uid = await Services.getUserId() ?? '2';
    final data = await Services.postData(
        {'company_id': uid}, 'company_view_service.php');
    return data;
  }

  Future<dynamic> addService() async {
    String uid = await Services.getUserId() ?? '2';
    final data =
        await Services.postData({'company_id': uid}, 'add_service.php');
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('add service'),
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddServiceScreen(),
            ),
          );
        },
      ),
      body: FutureBuilder(
          future: getCompanyServices(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return const CircularProgressIndicator();
            } else {
              if (snap.data[0]['message'] == 'Failed to View') {
                return const Center(child: Text('No services added yet'));
              } else {
                return ListView.builder(
                    itemCount: snap.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            snap.data[index]['name'],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Text(snap.data[index]['place']),
                              Text(snap.data[index]['type']),
                            ]),
                          ),
                        ),
                      );
                    });
              }
            }
          }),
    );
  }
}
