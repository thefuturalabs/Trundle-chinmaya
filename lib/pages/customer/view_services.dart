import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trundle/pages/customer/booked_services_page.dart';
import 'package:trundle/pages/customer/booked_vehicles_screen.dart';
import 'package:trundle/services/services.dart';

class ViewServices extends StatelessWidget {
  const ViewServices({super.key});

  Future<dynamic> getServicesList() async {
    final data = await Services.getData('view_service_list.php');
    return data;
  }

  bookService(String serviceId) async {
    String uid = await Services.getUserId() ?? '2';
    final data = await Services.postData(
        {'customer_id': uid, 'service_id': serviceId}, 'book_service.php');
    if (data['result'] == 'booked') {
      Fluttertoast.showToast(msg: 'Booked for service');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
           Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookedServices(),
                      ),
                    );
        },
        child: Icon(Icons.history),
      ),
      appBar: AppBar(),
      body: FutureBuilder(
          future: getServicesList(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                  itemCount: snap.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.construction),
                        title: Text((snap.data as List)[index]['name']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text((snap.data as List)[index]['mobile']),
                            Text((snap.data as List)[index]['place']),
                          ],
                        ),
                        trailing: ElevatedButton(
                            onPressed: () {
                              bookService(
                                  (snap.data as List)[index]['service_id']);
                            },
                            child: Text('Book')),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
