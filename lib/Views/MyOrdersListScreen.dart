import 'dart:convert';
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
  Future<List<Order>> getMyOrders() async {
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
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: Text("הזמנות"),
          backgroundColor: Colors.lightBlue.shade300,
          foregroundColor: Colors.white,
          elevation: 3,
        ),
        body: FutureBuilder<List<Order>>(
          future: getMyOrders(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'אין הזמנות',
                    style: TextStyle(fontSize: 28, color: Colors.black54),
                  ),
                );
              } else {
                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Order order = snapshot.data![index];
                    return Card(
                      color: Colors.grey.shade200,
                      elevation: 2,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OrderDetails(
                                orderId: 12,
                                items: [],
                              ),
                            ),
                          );
                        },
                        title: Text(
                          order.address,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        subtitle: Text(
                          "מספר הזמנה: ${order.orderID}\n"
                              "תאריך הזמנה: ${order.orderTime}\n"
                              "סה\"כ: ${order.totalPrice} ₪",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        isThreeLine: true,
                        trailing: Icon(Icons.arrow_forward_ios, color: Colors.red.shade300),
                      ),
                    );
                  },
                );
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'שגיאה, נסה שוב',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blueAccent,
              ),
            );
          },
        ),
      ),
    );
  }
}
