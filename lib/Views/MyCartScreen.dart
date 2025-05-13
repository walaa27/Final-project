import 'dart:convert';
import 'package:final_project/Views/EndOrder.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/Product.dart';
import '../Utils/ClientConfing.dart';
import 'package:http/http.dart' as http;
import 'ProductDetailsScreen.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key, required this.title});
  final String title;

  @override
  State<MyCartScreen> createState() => MyCartScreenState();
}

class MyCartScreenState extends State<MyCartScreen> {
  Future getMyCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userID = prefs.getString('userID');

    var url = "carts/getMyCart.php?userID=" + userID.toString();
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath + url);
    List<Product> arr = [];

    for (Map<String, dynamic> i in json.decode(response.body)) {
      arr.add(Product.fromJson(i));
    }
    return arr;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFF2F2F2), // رمادي فاتح خلفية ناعمة
        appBar: AppBar(
          backgroundColor: Color(0xFFB3E5FC), // أزرق فاتح
          elevation: 2,
          centerTitle: true,
          title: Text(
            widget.title,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),

        body: FutureBuilder(
          future: getMyCart(),
          builder: (context, projectSnap) {
            if (projectSnap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.redAccent),
              );
            }

            if (projectSnap.hasError) {
              print(projectSnap.error);
              return Center(
                child: Text(
                  'שגיאה, נסה שוב',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              );
            }

            if (projectSnap.hasData) {
              if (projectSnap.data.length == 0) {
                return Center(
                  child: Text(
                    'אין תוצאות',
                    style: TextStyle(fontSize: 23, color: Colors.black),
                  ),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: projectSnap.data.length,
                        itemBuilder: (context, index) {
                          Product project = projectSnap.data[index];
                          return Card(
                            margin:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: Colors.white,
                            elevation: 2,
                            child: ListTile(
                              onTap: () async {
                                final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                                await prefs.setInt(
                                    'lastProductID', project.productID);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailsScreen(
                                        title: project.productName),
                                  ),
                                );
                              },
                              contentPadding: const EdgeInsets.all(12),
                              title: Text(
                                project.productName!,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              subtitle: Text(
                                '${project.productPrice!.toString()} ש"ח',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.red.shade300,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  project.imageURL,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            }

            return Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            );
          },
        ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEF9A9A), // أحمر فاتح
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                final SharedPreferences prefs =
                await SharedPreferences.getInstance();
                final String? userName = prefs.getString('userName');

                List<Product> cartItems = await getMyCart();
                double totalPrice = 0;
                for (var item in cartItems) {
                  totalPrice += item.productPrice ?? 0;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Endorder(
                      userName: userName ?? 'אורח',
                      cartItems: cartItems,
                      totalPrice: totalPrice,
                    ),
                  ),
                );
              },
              child: Text(
                'סיום הזמנה',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
