import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Models/checkLoginModel.dart';
import 'Utils/ClientConfing.dart';
import 'Utils/Utils.dart';
import 'Views/HomePageScreen.dart';
import 'Views/RegisterScreen.dart';

void main() {
  runApp(const MyApp());
}

final _txtPhoneOrEmail = TextEditingController();
final _txtPaswoord = TextEditingController();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primaryColor: Colors.blue.shade700,
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
  @override
  void initState() {
    super.initState();
    checkConction();
    fillSavedPars();
  }

  void fillSavedPars() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _txtPhoneOrEmail.text = prefs.getString("email") ?? "";
    _txtPaswoord.text = prefs.getString("password") ?? "";
    if (_txtPhoneOrEmail.text.isNotEmpty && _txtPaswoord.text.isNotEmpty) {
      checkLogin(context);
    }
  }

  Future checkLogin(BuildContext context) async {
    if (_txtPaswoord.text.isEmpty || _txtPhoneOrEmail.text.isEmpty) {
      Utils().showMyDialog(context, "חובה", "בבקשה הזן את מספר הטלפון או האיימיל והסיסמה");
    } else {
      final url =
          "login/checkLogin.php?email=${_txtPhoneOrEmail.text}&password=${_txtPaswoord.text}";
      final response = await http.get(Uri.parse(serverPath + url));

      final data = checkLoginModel.fromJson(jsonDecode(response.body));
      if (data.userID == 0) {
        Utils().showMyDialog(context, "שגיאה", "אימיל ו/או הסיסמה שגויים");
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userID', data.userID.toString());
        await prefs.setString('email', _txtPhoneOrEmail.text);
        await prefs.setString('password', _txtPaswoord.text);
        await prefs.setString('FirstName', data.FirstName ?? "");
        await prefs.setString('LastName', data.LastName ?? "");

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Homepagescreen(title: "בית")),
        );
      }
    }
  }

  void checkConction() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // Connected
      }
    } on SocketException catch (_) {
      Utils().showMyDialog(context, "אין אינטרנט", "האפליקציה דורשת חיבור לאינטרנט, נא להתחבר בבקשה");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50, // خلفية أزرق فاتح
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: const Text(
          "סופר-פארם",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 400,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "* מספר טלפון / אימייל",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _txtPhoneOrEmail,
                decoration: InputDecoration(
                  hintText: 'הזן טלפון או אימייל',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "* סיסמה",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _txtPaswoord,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'הזן סיסמה',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade200,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () => checkLogin(context),
                  child: const Text("כניסה", style: TextStyle(fontSize: 18)),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Registerscreen(title: "חשבון חדש")),
                  );
                },
                child: const Text(
                  "חשבון חדש",
                  style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
