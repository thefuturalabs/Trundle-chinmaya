import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trundle/pages/rental_company/vehicle_add_screen.dart';
import 'package:trundle/services/services.dart';
import 'package:trundle/widgets/company_drawer.dart';

class CompanyHomePage extends StatefulWidget {
  const CompanyHomePage({super.key});

  @override
  State<CompanyHomePage> createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<CompanyHomePage> {
  Future<dynamic> getRequestList() async {
    String uid = await Services.getUserId() ?? '2';
    final data =
        await Services.postData({'company_id': uid}, 'all_vehicle_request.php');
    return data;
  }

  acceptOrRejectRequest(String acOrrej, String bookId) async {
    if(acOrrej=='accept'){
      final data=await Services.postData({'book_id':bookId}, 'accept_vehicle_request.php');
      if(data['result']=='accepted'){
        Fluttertoast.showToast(msg: 'request accepted');
        setState(() {
          
        });
      }else{
        final data=await Services.postData({'book_id':bookId}, 'reject_vehicle_request.php');
      if(data['result']=='rejected'){
        Fluttertoast.showToast(msg: 'request rejected');
        setState(() {
          
        });
      }
    }
  }}

  Future<void> refresh()async{
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CompanyDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('add vehicle'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddVehicleSceen(),
            ),
          );
        },
        icon: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text('Trundle'),),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder(
            future: getRequestList(),
            builder: (context, snap) {
              if (!snap.hasData) {
                return CircularProgressIndicator();
              } else if (snap.data[0]['message'] == 'Failed to View') {
                return Center(
                  child: Text('No Requests yet'),
                );
              } else {
                return ListView.builder(
                    itemCount: snap.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.construction),
                          title: Text((snap.data as List)[index]['name']),
                          // subtitle: Text((snap.data as List)[index]['status']),
                          trailing: (snap.data as List)[index]['status']=='0'? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MaterialButton(
                                color: Colors.green,
                                  onPressed: () {
                                    acceptOrRejectRequest('accept', (snap.data as List)[index]['book_id']);
                                  },
                                  child: Text('ACCEPT'),),
                                  SizedBox(width: 5,),
                                  MaterialButton(
                                color: Colors.red,
                                  onPressed: () {
                                   acceptOrRejectRequest('reject', (snap.data as List)[index]['book_id']);
                                  },
                                  child: Text('REJECT')),
                            ],
                          ):(snap.data as List)[index]['status']=='1'?const Text('ACCEPTED'):const Text('REJECTED'),
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}
