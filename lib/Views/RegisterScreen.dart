import 'package:flutter/material.dart';
import '../Models/User.dart';
import '../Utils/DB.dart';
import '../Utils/Utils.dart';
import 'HomePageScreen.dart';


class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key, required this.title});


  final String title;

  @override
  State<Registerscreen> createState() => RegisterscreenPageState();
}

class RegisterscreenPageState extends State<Registerscreen> {
  int _counter = 0;
  // final _txtId =TextEditingController();
  final _txtUserName =TextEditingController();
  final _txtLastName =TextEditingController();
  // final _txtEmail =TextEditingController();
  final _txtPaswoord =TextEditingController();
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

            Text("User Name :" , style: TextStyle( fontSize: 20),),
            Container(
              width: 500,
              child: TextField(
                controller: _txtUserName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter User Name',
                ),
              ),
            ),


            Text("Last Name:" , style: TextStyle( fontSize: 20),),
            Container(
              width: 500,
              child: TextField(
                controller: _txtLastName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter last name',
                ),
              ),
            ),





            Text("Paswoord:" , style: TextStyle( fontSize: 20),),
            Container(
              width: 500,
              child: TextField(
                controller: _txtPaswoord,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Paswoord',
                ),
              ),
            ),

/*
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepagescreen(title: 'HomePageScreen',)),
                );
              },
              child: Text('Register'),
            ),
            */
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                User us =new User();
                us.FirstName = _txtUserName.text;
                us.LastName = _txtLastName.text;
                us.Password = _txtPaswoord.text;
                insertUser(us);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepagescreen(title: 'HomePageScreen',)),
                );

                // var uti = new Utils();
                // uti.showMyDialog(context, _txtEmail.text,_txtId.text );
              },
              child: Text('Register'),
            ),

//

          ],
        ),
      ),

    );
  }
}
