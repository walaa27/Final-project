import 'package:flutter/material.dart';

class Shoppingcart extends StatefulWidget {
  @override
  ShoppingcartState createState() => ShoppingcartState();
}

class ShoppingcartState {
}

class _BasketScreenState extends State<Shoppingcart> {
  List<Map<String, dynamic>> basketBooks = [
  ];

  double get totalPrice =>
      basketBooks.fold(0, (sum, book) => sum + book["price"]);

  void removeBook(int index) {
    setState(() {
      basketBooks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Basket"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: basketBooks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(basketBooks[index]["title"]),
                    subtitle: Text("Price: \$${basketBooks[index]["price"]}"),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () => removeBook(index),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Text("Total: \$${totalPrice.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Proceeding to checkout...")));
              },
              child: Text("Checkout"),
            ),
          ],
        ),
      ),
    );
  }
}