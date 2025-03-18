import 'dart:convert';

import 'package:final_project/Models/Order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Utils/ClientConfing.dart';

class Orders extends StatefulWidget {
  const Orders({super.key, required this.title});

  final String title;

  @override
  State<Orders> createState() => OrdersPageState();
}


class OrdersPageState extends State<Orders> {
  /*
  final List<Map<String, dynamic>> orders = [
    {"id": 1, "total": 150.0, "date": "2025-02-08"},
    {"id": 2, "total": 230.5, "date": "2025-02-07"},
    {"id": 3, "total": 99.99, "date": "2025-02-06"},
  ];
*/

  Future getMyOrders() async {

    var url = "orders/getOrders.php";
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath + url);
    List<Order> arr = [];

    for(Map<String, dynamic> i in json.decode(response.body)){
      arr.add(Order.fromJson(i));
    }

    return arr;
  }


  int? selectedOrderId;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            selectedOrderId == null
                ? widget.title
                : "תאריך ההזמנה:: $selectedOrderId",
            textAlign: TextAlign.right,
          ),
          leading: selectedOrderId != null
              ? IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                selectedOrderId = null;
              });
            },
          )
              : null,
        ),
        body: FutureBuilder(
          future: getMyOrders(),
      builder: (context, projectSnap) {
        if (projectSnap.hasData) {
          if (projectSnap.data.length == 0)
          {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 2,
              child: Align(
                  alignment: Alignment.center,
                  child: Text('אין תוצאות', style: TextStyle(fontSize: 23, color: Colors.black))
              ),
            );
          }
          else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Expanded(
                    child:ListView.builder(
                      itemCount: projectSnap.data.length,
                      itemBuilder: (context, index) {
                        Order project = projectSnap.data[index];

                        return Card(
                            child: ListTile(
                              onTap: () {


                              },
                              title: Text(project.orderTime!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),), // Icon(Icons.timer),
                              subtitle: Text(project.totalPrice!.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                              trailing: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                child: Text(
                                  project.address!,   // + "שעות "
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),

                              isThreeLine: false,
                            ));
                      },
                    )),
              ],
            );
          }
        }
        else if (projectSnap.hasError)
        {
          print(projectSnap.error);
          return  Center(child: Text('שגיאה, נסה שוב', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)));
        }
        return Center(child: new CircularProgressIndicator(color: Colors.red,));
      },
    )

    // : Center(
    //       child: Text(
    //         "תוכן ההזמנה: $selectedOrderId",
    //         style: TextStyle(fontSize: 18),
    //         textAlign: TextAlign.right,
    //       ),
    //     ),
      ),
    );
  }
}

class OrderDetailsPage extends StatelessWidget {
  final int orderId;

  const OrderDetailsPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("ההזמנה $orderId", textAlign: TextAlign.right),
        ),
        body: Center(
          child: Text(
            "פרטי ההזמנה: $orderId",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
}
