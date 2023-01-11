import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trundle/services/services.dart';
// import 'package:geocoding/geocoding.dart' ;

class BookedVehicles extends StatefulWidget {
  const BookedVehicles({super.key});

  @override
  State<BookedVehicles> createState() => _BookedVehiclesState();
}

class _BookedVehiclesState extends State<BookedVehicles> {
  Future<dynamic> getBookedVehiclesList() async {
    String uid = await Services.getUserId() ?? '2';
    final data = await Services.postData(
      {'customer_id': uid},
      'all_booked_vehicle.php',
    );
    return data;
  }

  Future<void> refresh() async {
    setState(() {});
  }

  Widget? trailingButton(
      String bookingStatus, String returnStatus, String bookId) {
    if (bookingStatus == '0') {
      return null;
    } else if (bookingStatus == '1') {
      if (returnStatus == '0') {
        return ElevatedButton(
            onPressed: () {
              returnVehicle(bookId);
            },
            child: Text('return'));
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Widget? subTitle(String bookingStatus, String returnStatus) {
    if (bookingStatus == '0') {
      return Text('order pending');
    } else if (bookingStatus == '1') {
      if (returnStatus == '0') {
        return Text('order accepted');
      } else if (returnStatus == '1') {
        return Text('return requested');
      } else if (returnStatus == '2') {
        return Text('return accepted');
      }else{
        return Text('return rejected');
      }
    } else {
      return Text('order rejected');
    }
  }

  Color tileColor(String bookingStatus, String returnStatus){
    if (bookingStatus == '0') {
      return Colors.amber;
    } else if (bookingStatus == '1') {
      if (returnStatus == '0') {
        return Colors.green;
      } else if (returnStatus == '1') {
        return Colors.blue;
      } else if (returnStatus == '2') {
        return Colors.green;
      }else{
        return Colors.red;
      }
    } else {
      return Colors.red;
    }
  }

  returnVehicle(String bookId) async {
    final data = await Services.postData(
      {'book_id': bookId},
      'return_status.php',
    );
    if(data['result']=='requested'){
      Fluttertoast.showToast(msg: 'return requested');
      setState(() {  
      });
    }
  }

  // bookService(String serviceId) async {
  @override
  Widget build(BuildContext context) {
    print('rebuilt');
    return Scaffold(
      appBar: AppBar(title: Text('Order history'),),
      body: FutureBuilder(
          future: getBookedVehiclesList(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return const CircularProgressIndicator();
            } else if(snap.data[0]['message']=='Failed to View') {
              return Center(child: Text('No history yet'));
            }else{
              return RefreshIndicator(
                onRefresh: refresh,
                child: ListView.builder(
                    itemCount: snap.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: tileColor( (snap.data as List)[index]['status'],
                              (snap.data as List)[index]['return_status']),
                        child: ListTile(
                          leading: const Icon(Icons.drive_eta),
                          title: Text((snap.data as List)[index]['name']),
                          subtitle: subTitle(
                              (snap.data as List)[index]['status'],
                              (snap.data as List)[index]['return_status']),
                          trailing: trailingButton(
                            (snap.data as List)[index]['status'],
                            (snap.data as List)[index]['return_status'],
                            (snap.data as List)[index]['book_id'],
                          ),
                        ),
                      );
                    }),
              );
            }
          }),
    );
  }
}
