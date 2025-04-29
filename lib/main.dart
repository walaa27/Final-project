import 'dart:convert';
import 'dart:io';

import 'package:final_project/Views/HomePageScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/User.dart';
import 'Models/checkLoginModel.dart';
import 'Utils/ClientConfing.dart';

import 'Utils/Utils.dart';
import 'Views/RegisterScreen.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const MyApp());
}
final _txtPhoneOrEmail =TextEditingController();
final _txtPaswoord =TextEditingController();

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



  fillSavedPars() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _txtPhoneOrEmail.text = prefs.get("email").toString();
    _txtPaswoord.text = prefs.get("password").toString();
    if(_txtPhoneOrEmail.text != "" && _txtPaswoord.text != "")
    {
      checkLogin(context);
    }
  }




  Future checkLogin(BuildContext context) async {

    if(_txtPaswoord.text == "" || _txtPhoneOrEmail.text == "")
    {
      var uti = new Utils();
      uti.showMyDialog(context, "חובה", "בבקשה הזן את שם התעודת זהות ןמספר הטלפון או האיימל שלך");
    }
    else
      {
        //   SharedPreferences prefs = await SharedPreferences.getInstance();
        //  String? getInfoDeviceSTR = prefs.getString("getInfoDeviceSTR");
        var url = "login/checkLogin.php?email=" + _txtPhoneOrEmail.text + "&password=" +  _txtPaswoord.text;
        final response = await http.get(Uri.parse(serverPath + url));
        print(serverPath + url);
        // setState(() { });
        // Navigator.pop(context);
        if(checkLoginModel.fromJson(jsonDecode(response.body)).userID == 0)
        {
          // return ' אימיל ו/או הסיסמה שגויים';
          var uti = new Utils();
          uti.showMyDialog(context, "שגיאה", "אימיל ו/או הסיסמה שגויים");
        }
        else
        {
          // print("SharedPreferences 1");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userID', checkLoginModel.fromJson(jsonDecode(response.body)).userID!.toString());
          await prefs.setString('email', _txtPhoneOrEmail.text);
          await prefs.setString('password', _txtPaswoord.text);

          Navigator.push(
            context,
            MaterialPageRoute(builder:(context) => const Homepagescreen(title: "בית")),
          );
        }
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

    fillSavedPars();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("סופר פארם"),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(" :*מספר טלפון או אימיל" , style: TextStyle( fontSize: 20),),
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

            Text(":*סיסמה" , style: TextStyle( fontSize: 20),),
            Container(
              width: 500,
              child: TextField(
                controller: _txtPaswoord,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'הזן את הסיסמה - חובה',
                ),
              ),
            ),



            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                // insertUserFunc();
                checkLogin(context);
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
              child: Text ('חשבון חדש'),
            ),

          ],
        ),
      ),

    );
  }
}
