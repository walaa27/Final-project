import 'dart:io';

import 'package:final_project/Views/HomePageScreen.dart';
import 'package:flutter/material.dart';
import 'Models/User.dart';
import 'Utils/DB.dart';
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
  // final _txtId =TextEditingController();
  final _txtUserID=TextEditingController();
  final _txtPhoneOrEmail =TextEditingController();



  void insertUserFunc()
  {
    if(_txtUserID.text == "" || _txtPhoneOrEmail.text == "")
    {
      var uti = new Utils();
      uti.showMyDialog(context, "חובה", "בבקשה הזן את שם התעודת זהות ןמספר הטלפון או האיימל שלך");


  /*
        print("resp: " + resp.toString());
        if(resp == "1")
          {
            Navigator.push(
               context,
              MaterialPageRoute(builder: (context) => Homepagescreen(title: 'HomePageScreen',)),
             );
          }
         */
  // var uti = new Utils();
  // uti.showMyDialog(context, "success", "you registed successfully");
  // _txtPaswoord.text = "";
  // _txtUserName.text = "";
  // _txtLastName.text = "";
  // Navigator.push(
  //    context,
  //   MaterialPageRoute(builder: (context) => Homepagescreen(title: 'HomePageScreen',)),
  //  );

  }
  else
  {
    var us = new User();
    us.UserID = _txtUserID.text;
    us.PhoneOrEmail = _txtPhoneOrEmail.text;

    var resp = insertUser(us);
    Navigator.push(
      context,
      MaterialPageRoute(builder:(context) => const Homepagescreen(title: "בית")),
    );

  }
  }
  checkConction() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // print('connected to internet');// print(result);// return 1;
      }
    } on SocketException catch (_) {
      // print('not connected to internet');// print(result);
      var uti = new Utils();
      uti.showMyDialog(context, "אין אינטרנט", "האפליקציה דורשת חיבור לאינטרנט, נא להתחבר בבקשה");
      return;
    }
  }


  @override
  Widget build(BuildContext context) {
    checkConction();


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
                controller: _txtUserID,
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
                controller: _txtPhoneOrEmail,
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

                insertUserFunc();


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
