import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trundle/pages/rental_company/add_service_screen.dart';
import 'package:trundle/pages/rental_company/edit_service_screen.dart';
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

  Future<void> referesh() async {
    setState(() {});
  }

  Future<bool> deleteService(String serviceId) async {
    try {
      Map response = await Services.postData(
          {'service_id': serviceId}, 'remove_service.php');
      return response['message'] != 'Failed';
    } on Exception {
      return false;
    }
  }

  late double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenHeight= MediaQuery.of(context).size.height;
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
                return RefreshIndicator(
                  onRefresh: referesh,
                  child: SingleChildScrollView(
                      child: SizedBox(
                        height: screenHeight+1,
                        child: const Center(child: Text('No services added yet')))),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: referesh,
                  child: ListView.builder(
                      itemCount: snap.data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditServiceScreen(
                                  serviceId: snap.data[index]['service_id'],
                                ),
                              ),
                            );
                          },
                          child: Dismissible(
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (dir) async {
                              bool dismiss = false;
                              return await showDialog<bool>(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: Text('Confirm deletion?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              dismiss = false;
                                            },
                                            child: Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              dismiss = await deleteService(snap
                                                  .data[index]['service_id']);
                                              Navigator.pop(context);
                                            },
                                            child: Text('Yes'),
                                          ),
                                        ],
                                      )).then((value) => dismiss);
                            },
                            background: Container(
                              color: Color.fromARGB(255, 136, 9, 0),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('remove'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(Icons.delete)
                                      ],
                                    ),
                                  )),
                            ),
                            key: GlobalKey(
                                debugLabel: snap.data[index]['service_id']),
                            onDismissed: (dir) async {},
                            child: Card(
                              child: ListTile(
                                title: Text(
                                  snap.data[index]['name'],
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(snap.data[index]['place']),
                                        Text(snap.data[index]['type']),
                                      ]),
                                ),
                                trailing: IconButton(icon: Icon(Icons.delete),onPressed: (){
                                  Fluttertoast.showToast(msg: 'Swipe left to remove');
                                }),
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }
            }
          }),
    );
  }
}
