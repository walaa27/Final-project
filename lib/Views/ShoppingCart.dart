import 'package:flutter/material.dart';

import 'Homepagescreen.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key, required this.title});

  final String title;

  @override
  State<ShoppingCart> createState() => ShoppingCartPageState();
}

class ShoppingCartPageState extends State<ShoppingCart> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> const Homepagescreen(title :" HomePage")),
                );
              },
              child: Text(''),
            ),

          ],
        ),
      ),
    );
  }
  }