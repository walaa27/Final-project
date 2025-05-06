import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/Order.dart';
import '../Utils/ClientConfing.dart';
import 'OrderDetailsScreen.dart';

class Orders extends StatefulWidget {
  const Orders({super.key, required this.title});
  final String title;

  @override
  State<Orders> createState() => OrdersPageState();
}

class OrdersPageState extends State<Orders> {

  Future getMyOrders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userID = prefs.getString('userID');

    var url = "orders/getMyOrders.php?userID=" + userID!;
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath + url);
    List<Order> arr = [];

    for (Map<String, dynamic> i in json.decode(response.body)) {
      arr.add(Order.fromJson(i));
    }
    return arr;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(title: Text("הזמנות")
          ),
          body: FutureBuilder(
            future: getMyOrders(),
            builder: (context, projectSnap) {
              if (projectSnap.hasData) {
                if (projectSnap.data.length == 0) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 5,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text('אין הזמנות',
                            style:
                            TextStyle(fontSize: 50, color: Colors.black))),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: ListView.builder(
                            itemCount: projectSnap.data.length,
                            itemBuilder: (context, index) {
                              Order project = projectSnap.data[index];

                              return Card(
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder:(context) => const OrderDetails(orderId: 12, items: [],)),
                                      );
                                    },
                                    title: Text(
                                      project.address,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ), // Icon(Icons.timer),
                                    subtitle: Text(
                                      "מספר הזמנה: ${project.orderID}\nתאריך הזמנה: ${project.orderTime}\nסה"
                                          "כ: ${project.totalPrice.toString()} שח\n",
                                      style:
                                      TextStyle(fontSize: 18, color: Colors.black),
                                    ),
                                    isThreeLine: true,
                                  ));
                            },
                          )),
                    ],
                  );
                }
              } else if (projectSnap.hasError) {
                print(projectSnap.error);
                return Center(
                    child: Text('שגיאה, נסה שוב',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)));
              }
              return Center(
                  child: new CircularProgressIndicator(
                    color: Colors.red,
                  ));
            },
          )),
    );
  }
}
