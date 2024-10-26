import 'package:flutter/material.dart';

class Homepagescreen extends StatefulWidget {
  const Homepagescreen({super.key, required this.title});


  final String title;

  @override
  State<Homepagescreen> createState() => _Homepagescreen();
}

class _Homepagescreen extends State<Homepagescreen> {
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

        title: Text("Home"),
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


              },  child: Icon(Icons.account_circle ),
            ),




          ],
        ),
      ),

    );
  }
}
