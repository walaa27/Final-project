import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  final int orderId;
  final List<Map<String, dynamic>> items;

  const OrderDetails({super.key, required this.orderId, required this.items});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("تفاصيل الطلبية رقم $orderId"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: Text(
                    item['name'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "السعر: ₪${item['price']} \nالكمية: ${item['quantity']}",
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: Icon(Icons.shopping_cart, color: Colors.blue),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}