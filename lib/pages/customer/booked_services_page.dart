import 'package:flutter/material.dart';
import 'package:trundle/services/services.dart';

class BookedServices extends StatelessWidget {
  const BookedServices({super.key});

  Future<dynamic> getBookedVehiclesList() async {
    String uid = await Services.getUserId() ?? '2';
    final data = await Services.postData(
      {'customer_id': uid},
      'all_booked_service.php',
    );
    return data;
  }

  // bookService(String serviceId) async {
  //   String uid = await Services.getUserId() ?? '2';
  //   final data = await Services.postData(
  //       {'customer_id': uid, 'service_id': serviceId}, 'book_service.php');
  //   if (data['result'] == 'booked') {
  //     Fluttertoast.showToast(msg: 'Booked for service');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: getBookedVehiclesList(),
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
                        subtitle: Text(
                          (snap.data as List)[index]['status'] == '0'
                              ? 'pending'
                              : (snap.data as List)[index]['status'] == '1'
                                  ? 'accepted'
                                  : 'rejected',
                        ),
                        // trailing: ElevatedButton(
                        //     onPressed: () {
                        //       // bookService((snap.data as List)[index]['service_id']);
                        //     },
                        //     child: Text('cancel order')),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
