import 'dart:convert';
import 'package:final_project/Models/Category.dart';
import 'package:final_project/Views/ProductsListScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/Order.dart';
import '../Utils/ClientConfing.dart';
import 'EditProfileScreen.dart';
import 'Orders.dart';
import 'Search.dart';
import 'Carts.dart';
import 'package:http/http.dart' as http;

class Homepagescreen extends StatefulWidget {
  const Homepagescreen({super.key, required this.title});


  final String title;

  @override
  State<Homepagescreen> createState() => _Homepagescreen();

}

class _Homepagescreen extends State<Homepagescreen> {
  int _counter = 0;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: ראשי',
      style: optionStyle,
    ),
    Text(
      'Index 1: הסל שלי',
      style: optionStyle,
    ),
    Text(
      'Index 2: חיפוש',
      style: optionStyle,
    ),
    Text(
      'Index 3: הזמנות',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if(index == 1)
      {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Carts(
                title: "Carts",
              ),
            )
        );
      }
      else if(index == 2)
      {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Searchs(
                title: "Searchs",
              ),
            )
        );
      }
      else if(index == 3)
      {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Orders(
                title: "Orders",
              ),
            )
        );
      }
    });
  }
  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }
  Future getMyCategories() async {

    var url = "categories/getCategories.php";
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath + url);
    List<category> arr = [];

    for(Map<String, dynamic> i in json.decode(response.body)){
      arr.add(category.fromJson(i));
    }
print("arr:" + arr.length.toString());
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
        future: getMyCategories(),
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
                          category project = projectSnap.data[index];

                          return Card(
                              child: ListTile(
                                onTap: () async {

                                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                                  await prefs.setInt('lastCatID', project.categoryID);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ProductsListScreen(title: project.categoryName,)),
                                  );

                                },
                                title: Text(project.categoryName!.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),), // Icon(Icons.timer),
                                trailing: Image.network(project.imageCat,
                                ),
                                // subtitle: Text(project.categoryName!.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                                // trailing: Container(
                                //   decoration: const BoxDecoration(
                                //     color: Colors.blue,
                                //     borderRadius: BorderRadius.all(Radius.circular(5)),
                                //   ),
                                //   padding: const EdgeInsets.symmetric(
                                //     horizontal: 12,
                                //     vertical: 4,
                                //   ),
                                //
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
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Add Content'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Edit Profile'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ראשי',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),

            label: 'הסל שלי',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'חיפוש',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sticky_note_2_outlined),
            label: 'הזמנות',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
