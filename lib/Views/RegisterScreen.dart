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
  final _txtFirstName =TextEditingController();
  final _txtLastName =TextEditingController();
  // final _txtEmail =TextEditingController();
  final _txtPaswoord =TextEditingController();


  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }


  void insertUserFunc()
  {
    if(_txtFirstName.text != "" && _txtPaswoord.text != "")

      {
        User us = new User();
        us.FirstName = _txtFirstName.text;
        us.LastName = _txtLastName.text;
        us.Password = _txtPaswoord.text;
        var resp = insertUser(us);

        Future.delayed(
          Duration(seconds: 2),
              () =>    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Homepagescreen(title: 'HomePageScreen',)),
              ),
        );

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
        var uti = new Utils();
        uti.showMyDialog(context, "Required", "please insert username and password");
      }
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

            Text("First Name*:" , style: TextStyle( fontSize: 20),),
            Container(
              width: 500,
              child: TextField(
                controller: _txtFirstName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter First Name - required',
                ),
              ),
            ),
            Text("Last Name*:" , style: TextStyle( fontSize: 20),),
            Container(
              width: 500,
              child: TextField(
                controller: _txtLastName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter last name - required',
                ),
              ),
            ),





            Text("Password*:" , style: TextStyle( fontSize: 20),),
            Container(
              width: 500,
              child: TextField(
                controller: _txtPaswoord,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Password-required',
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

                insertUserFunc();

                /*
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepagescreen(title: 'HomePageScreen',)),
                );
*/
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
