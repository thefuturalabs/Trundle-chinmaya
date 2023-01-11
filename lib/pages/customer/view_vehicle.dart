import 'package:flutter/material.dart';
import 'package:trundle/constants.dart';
import 'package:trundle/pages/customer/payment_screen.dart';
import 'package:trundle/services/services.dart';

class ViewVehicle extends StatelessWidget {
  ViewVehicle({super.key, required this.vehicleId,});
  String vehicleId;
  
  Future<dynamic> getVehicleDetails() async {
    final data =
        await Services.postData({'vehicle_id': vehicleId}, 'vehicle_view.php');
    return data[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getVehicleDetails(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return CircularProgressIndicator();
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                snap.data['photo'],
                              ),
                              fit: BoxFit.cover),
                        ),
                        child: Image.network(Constants.imageUrl+ snap.data['photo']),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          snap.data['name'],
                          style: const TextStyle(
                              color: Color.fromARGB(255, 169, 200, 226),
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'Reg no: ${snap.data['Reg_no']}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 169, 200, 226),
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'color: ${snap.data['color']}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 169, 200, 226),
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'category: ${snap.data['type']}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 169, 200, 226),
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'fuel: ${snap.data['fuel_type']}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 169, 200, 226),
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'price: ${snap.data['price']}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 169, 200, 226),
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Services.getUserId().then((value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PaymentScreen(
                                    vehicleId: vehicleId,
                                    customerId: value ?? '2',
                                    price: snap.data['price'],
                                  ),
                                ),
                              );
                            });
                          },
                          child: Text('Book'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
