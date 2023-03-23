import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'package:trundle/constants.dart';
import 'package:trundle/pages/customer/view_vehicle.dart';
import 'package:trundle/services/services.dart';
import 'package:trundle/widgets/customer_drawer.dart';

class CustomerHomePage extends StatefulWidget {
  CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  List<String> categories = [];
  List<String> filteredCategoryList = [];
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredCategoryList = categories;
  }

  Future<dynamic> getVehicles() async {
    final data = await Services.getData('vehicle_list.php');
    // final vList = data.map((e) => Vehicle.fromJson(e)).toList();
    // print('!!!!!!!!!!!${vList}');
    data.forEach((element) {
      if (!categories.contains(element['type'])) {
        categories.add(element['type']);
      }
    });
    print(categories);
    return data;
  }

  getCategorisedVehicles(String category, List vehicles) {
    return vehicles
        .where(
          (element) =>
              element['type'] == category ||
              (element['name'] as String).toUpperCase().contains(category.toUpperCase()),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomerDrawer(),
      appBar: AppBar(
        title: Text('Trundle'),
      ),
      body: FutureBuilder(
          future: getVehicles(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return CircularProgressIndicator();
            } else {
              return Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SearchField(
                    hint: 'Search by either category or name',
                    controller: searchController,
                    onSubmit: (p0) {
                      if (p0 == '') {
                        setState(() {
                          filteredCategoryList = categories;
                        });
                      }
                    },
                    suggestions:
                        categories.map((e) => SearchFieldListItem(e)).toList(),
                    searchInputDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            filteredCategoryList = [searchController.text];
                          });
                        },
                        icon: Icon(Icons.search),
                      ),
                    ),
                    onSuggestionTap: (v) {
                      print(v.searchKey);
                      setState(() {
                        filteredCategoryList = [v.searchKey];
                      });
                    },
                  ),
                ),
                // DropdownSearch(),
                Expanded(
                  child: ListView.builder(
                      itemCount: filteredCategoryList.length,
                      itemBuilder: (context, verticalIndex) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  filteredCategoryList[verticalIndex],
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 169, 200, 226),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 202,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: getCategorisedVehicles(
                                          filteredCategoryList[verticalIndex],
                                          snap.data)
                                      .length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (_, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => ViewVehicle(
                                              vehicleId: getCategorisedVehicles(
                                                      filteredCategoryList[
                                                          verticalIndex],
                                                      snap.data)[index]
                                                  ['vehicle_id'],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 210, 213, 255),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        height: 200,
                                        width: 300,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 102,
                                              width: 250,
                                              child: Image.network(
                                                  Constants.imageUrl +
                                                      getCategorisedVehicles(
                                                              filteredCategoryList[
                                                                  verticalIndex],
                                                              snap.data)![index]
                                                          ['photo'],
                                                  fit: BoxFit.cover),
                                            ),
                                            Text(
                                                getCategorisedVehicles(
                                                    filteredCategoryList[
                                                        verticalIndex],
                                                    snap.data)![index]['name'],
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 14, 0, 65))),
                                            Text(
                                                getCategorisedVehicles(
                                                        filteredCategoryList[
                                                            verticalIndex],
                                                        snap.data)![index]
                                                    ['status'],
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 14, 0, 65))),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            Divider(),
                          ],
                        );
                      }),
                )
              ]);
            }
          }),
    );
  }
}
