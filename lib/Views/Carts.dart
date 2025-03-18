import 'dart:convert';
import 'package:final_project/Models/Cart.dart';
import 'package:flutter/material.dart';
import '../Utils/ClientConfing.dart';
import 'Homepagescreen.dart';
import 'package:http/http.dart' as http;



class Carts extends StatefulWidget {
  const Carts({super.key, required this.title});

  final String title;

  @override
  State<Carts> createState() => CartsPageState();
}

class CartsPageState extends State<Carts> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  Future getMyCarts() async {

    var url = "carts/getCarts.php?userID=1";
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath + url);
    List<Cart> arr = [];

    for(Map<String, dynamic> i in json.decode(response.body)){
      arr.add(Cart.fromJson(i));
    }

    return arr;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
        body: FutureBuilder(
          future: getMyCarts(),
          builder: (context, projectSnap) {
            if (projectSnap.hasData) {
              if (projectSnap.data.length == 0)
              {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 2,
                  child: Align(
                      alignment: Alignment.center,
                      child: Text('אין תוצאות', style: TextStyle(fontSize: 23, color: Colors.black))
                  ),
                );
              }
              else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Expanded(
                        child:ListView.builder(
                          itemCount: projectSnap.data.length,
                          itemBuilder: (context, index) {
                            Cart project = projectSnap.data[index];

                            return Card(
                                child: ListTile(
                                  onTap: () {


                                  },
                                  title: Text(project.userID!.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),), // Icon(Icons.timer),
                                  subtitle: Text(project.productname!.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                                  // trailing: Container(
                                  //   decoration: const BoxDecoration(
                                  //     color: Colors.blue,
                                  //     borderRadius: BorderRadius.all(Radius.circular(5)),
                                  //   ),
                                  //   padding: const EdgeInsets.symmetric(
                                  //     horizontal: 12,
                                  //     vertical: 4,
                                  //   ),
                                  //   child: Text(
                                  //     project.quantity.toString()!,   // + "שעות "
                                  //     overflow: TextOverflow.ellipsis,
                                  //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                  //   ),
                                  // ),

                                  isThreeLine: false,
                                ));
                          },
                        )),
                  ],
                );
              }
            }
            else if (projectSnap.hasError)
            {
              print(projectSnap.error);
              return  Center(child: Text('שגיאה, נסה שוב', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)));
            }
            return Center(child: new CircularProgressIndicator(color: Colors.red,));
          },
        )

    );
  }
  }