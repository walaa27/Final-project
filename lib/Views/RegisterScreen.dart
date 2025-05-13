import 'package:flutter/material.dart';
import '../Models/User.dart';
import '../Utils/ClientConfing.dart';
import '../Utils/Utils.dart';
import 'HomePageScreen.dart';
import 'package:http/http.dart' as http;

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key, required this.title});
  final String title;

  @override
  State<Registerscreen> createState() => RegisterscreenPageState();
}

class RegisterscreenPageState extends State<Registerscreen> {
  final _txtFirstName = TextEditingController();
  final _txtLastName = TextEditingController();
  final _txtPhoneOrEmail = TextEditingController();
  final _txtPaswoord = TextEditingController();

  Future insertUser(BuildContext context, User us) async {
    var url = "users/insertUser.php?firstName=${us.FirstName}&lastName=${us.LastName}&Password=${us.Password}&PhoneOrEmail=${us.PhoneOrEmail}";
    print(serverPath + url);
    final response = await http.get(Uri.parse(serverPath + url));
    setState(() {});
    Navigator.pop(context);
  }

  void insertUserFunc() {
    if (_txtFirstName.text != "" && _txtPaswoord.text != "") {
      User us = User();
      us.FirstName = _txtFirstName.text;
      us.LastName = _txtLastName.text;
      us.PhoneOrEmail = _txtPhoneOrEmail.text;
      us.Password = _txtPaswoord.text;
      insertUser(context, us);

      Future.delayed(
        Duration(seconds: 2),
            () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Homepagescreen(title: 'HomePageScreen')),
        ),
      );
    } else {
      var uti = Utils();
      uti.showMyDialog(context, "חובה", "בבקשה הזן את שם פרטי,שם משפחה והסיסמה");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.lightBlue.shade300,
          foregroundColor: Colors.white,
          elevation: 3,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLabel("שם פרטי *"),
              buildTextField(_txtFirstName, 'הזן את השם הפרטי - חובה'),
              buildLabel("שם משפחה *"),
              buildTextField(_txtLastName, 'הזן את שם המשפחה - חובה'),
              buildLabel("מספר טלפון או אימייל *"),
              buildTextField(_txtPhoneOrEmail, 'הזן מספר טלפון או אימייל - חובה'),
              buildLabel("סיסמה *"),
              buildTextField(_txtPaswoord, 'הזן את הסיסמה - חובה', isPassword: true),
              SizedBox(height: 25),
              Center(
                child: ElevatedButton(
                  onPressed: insertUserFunc,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade300,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text('הרשמה'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.blue.shade900),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String hint, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade200,
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade100),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
