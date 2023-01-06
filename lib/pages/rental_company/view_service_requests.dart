import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trundle/services/services.dart';

class ViewServiceRequests extends StatefulWidget {
  const ViewServiceRequests({super.key});

  @override
  State<ViewServiceRequests> createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<ViewServiceRequests> {
  Future<dynamic> getRequestList() async {
    String uid = await Services.getUserId() ?? '2';
    final data =
        await Services.postData({'company_id': uid}, 'all_service_request.php');
    return data;
  }

  acceptOrRejectRequest(String acOrrej, String bookId) async {
    if(acOrrej=='accept'){
      final data=await Services.postData({'book_id':bookId}, 'accept_service_request.php');
      if(data['result']=='accepted'){
        Fluttertoast.showToast(msg: 'request accepted');
        setState(() {
          
        });
      }else{
        final data=await Services.postData({'book_id':bookId}, 'reject_service_request.php');
      if(data['result']=='rejected'){
        Fluttertoast.showToast(msg: 'request rejected');
        setState(() {
          
        });
      }
    }
  }}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: CompanyDrawer(),
      // floatingActionButton: FloatingActionButton.extended(
      //   label: Text('add vehicle'),
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (_) => AddVehicleSceen(),
      //       ),
      //     );
      //   },
      //   icon: Icon(Icons.add),
      // ),
      appBar: AppBar(),
      body: FutureBuilder(
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
    );
  }
}
