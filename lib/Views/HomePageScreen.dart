import 'dart:convert';
import 'package:final_project/Models/Category.dart';
import 'package:final_project/Views/MyCartScreen.dart';
import 'package:final_project/Views/ProductsListScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/ClientConfing.dart';
import 'MyOrdersListScreen.dart';
import 'package:http/http.dart' as http;

class Homepagescreen extends StatefulWidget {
  const Homepagescreen({super.key, required this.title});
  final String title;

  @override
  State<Homepagescreen> createState() => _Homepagescreen();
}

class _Homepagescreen extends State<Homepagescreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyCartScreen(title: "הסל שלי"),
          ),
        );
      }  else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Orders(title: "ההזמנות שלי"),
          ),
        );
      }
    });
  }

  Future<List<category>> getMyCategories() async {
    var url = "categories/getCategories.php";
    final response = await http.get(Uri.parse(serverPath + url));
    List<category> arr = [];

    for (Map<String, dynamic> i in json.decode(response.body)) {
      arr.add(category.fromJson(i));
    }

    return arr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // سكّني فاتح خلفية الصفحة
      appBar: AppBar(
        backgroundColor: Colors.blue[100], // أزرق فاتح
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: getMyCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'אין תוצאות',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    category cat = snapshot.data![index];
                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(12),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            cat.imageCat,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          cat.categoryName ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blueGrey[900],
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, color: Colors.red[200]),
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setInt('lastCatID', cat.categoryID);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductsListScreen(title: cat.categoryName ?? ''),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'שגיאה, נסה שוב',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(color: Colors.red[200]),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ראשי'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_basket), label: 'הסל שלי'),
          BottomNavigationBarItem(icon: Icon(Icons.sticky_note_2_outlined), label: 'הזמנות'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red[400], // أحمر خفيف
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
