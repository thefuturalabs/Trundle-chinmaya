import 'package:flutter/material.dart';
import 'package:trundle/pages/customer/add_feedback_page.dart';
import 'package:trundle/services/services.dart';

class ViewFeedbacksPage extends StatefulWidget {
   ViewFeedbacksPage({super.key,required this.addFeedback});
bool addFeedback;
  @override
  State<ViewFeedbacksPage> createState() => _ViewFeedbacksPageState();
}

class _ViewFeedbacksPageState extends State<ViewFeedbacksPage> {
  Future<dynamic> getFeedbacksList() async {
    final data = await Services.getData('view_feedback.php');
    return data;
  }

  refreshPage(){
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:widget.addFeedback? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddFeedback(refresh: refreshPage),
            ),
          );
        },
        child: Icon(Icons.add),
      ):SizedBox(),
      body: FutureBuilder(
          future: getFeedbacksList(),
          builder: (_, snap) {
            if (!snap.hasData) {
              return CircularProgressIndicator();
            } else if(snap.data[0]['message']=='Failed to View'){
return Center(child: Text('No feedbacks yet'));
            }else{
              return ListView.builder(
                  itemCount: snap.data.length,
                  itemBuilder: (_, index) {
                    return Card(
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snap.data[index]['feedback']),
                              Text(
                                snap.data[index]['customer'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
