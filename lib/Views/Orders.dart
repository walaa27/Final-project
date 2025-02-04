import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key, required this.title});

  final String title;

  @override
  State<Orders> createState() => OrdersPageState();
}

class OrdersPageState extends State<Orders> {
  final List<Map<String, dynamic>> orders = [
    {"id": 1, "total": 150.0, "date": "2025-02-08"},
    {"id": 2, "total": 230.5, "date": "2025-02-07"},
    {"id": 3, "total": 99.99, "date": "2025-02-06"},
  ];

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
        body: selectedOrderId == null
            ? ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              margin: EdgeInsets.all(20),
              child: ListTile(
                title: Text(
                  "הזמנה : ${order['id']}",
                  textAlign: TextAlign.right,
                ),
                subtitle: Text(
                  "תאריך: ${order['date']}",
                  textAlign: TextAlign.right,
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "₪${order['total']}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 1),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailsPage(
                              orderId: order['id'],
                            ),
                          ),
                        );
                      },
                      child: Text("הצגת פרטים"),
                    ),
                  ],
                ),
              ),
            );
          },
        )
            : Center(
          child: Text(
            "תוכן ההזמנה: $selectedOrderId",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.right,
          ),
        ),
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
