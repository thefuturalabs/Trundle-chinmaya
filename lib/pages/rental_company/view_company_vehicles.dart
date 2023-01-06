import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trundle/constants.dart';
import 'package:trundle/services/services.dart';

class ViewCompanyVehicles extends StatefulWidget {
  const ViewCompanyVehicles({super.key});

  @override
  State<ViewCompanyVehicles> createState() => _ViewCompanyVehiclesState();
}

class _ViewCompanyVehiclesState extends State<ViewCompanyVehicles> {
  Future<dynamic> getCompanyVehicles() async {
    String uid = await Services.getUserId() ?? '2';
    final data = await Services.postData(
        {'company_id': uid}, 'company_view_vehicle.php');
    return data;
  }

  Future<dynamic> removeVehicle(String vehicleId) async {
    // String uid = await Services.getUserId() ?? '2';
    final data =
        await Services.postData({'vehicle_id': vehicleId}, 'remove_vehicle.php');
    if (data['result'] == 'done') {
      Fluttertoast.showToast(msg: 'vehicle removed');
      setState(() {});
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getCompanyVehicles(),
          builder: (context, snap) {
            if(!snap.hasData){
              return CircularProgressIndicator();
            }else{
            return ListView.builder(
              itemCount: snap.data.length,
              itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 171, 198, 220)),
                height: 350,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Image.network(
                          Constants.imageUrl + snap.data![index]['image'],
                          fit: BoxFit.cover),
                    ),
                    Text(snap.data![index]['name'],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(snap.data![index]['reg_no']),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            removeVehicle(snap.data![index]['vehicle_id']);
                          },
                          child: Text(
                            'remove',
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            });
}          }),
    );
  }
}
