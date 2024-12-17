import 'package:final_project/Views/HomePageScreen.dart';
import 'package:flutter/material.dart';
import 'Utils/Utils.dart';
import 'Views/RegisterScreen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

        title: Text("סופר פארם"),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text("תעודת זהות* :" , style: TextStyle( fontSize: 20),),
            Container(
              width: 500,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'הזן את תעודת הזהות - חובה',
                ),
              ),
            ),
            Text(" מספר טלפון או אימיל" , style: TextStyle( fontSize: 20),),
            Container(
              width: 500,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'הזן את מספר טלפון אימיל - חובה',
                ),
              ),
            ),


            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {

                Navigator.push(
                context,
                MaterialPageRoute(builder:(context) => const Homepagescreen(title: "בית")),
                );

              },
              child: Text('כניסה'),

            ),

            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder:(context) => const Registerscreen(title: "חשבון חדש")),
                );
              },
              child: Text('חשבון חדש'),
            ),

          ],
        ),
      ),

    );
  }
}
