import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/Product.dart';
import '../Utils/ClientConfing.dart';
import 'ProductDetailsScreen.dart';
import 'package:http/http.dart' as http;

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key, required this.title});
  final String title;

  @override
  State<ProductsListScreen> createState() => _ProductsListScreen();
}

class _ProductsListScreen extends State<ProductsListScreen> {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  Future<List<Product>> getProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? lastCategoryID = prefs.getInt('lastCatID');
    var url = "products/getProducts.php?categoryID=" + lastCategoryID.toString();
    final response = await http.get(Uri.parse(serverPath + url));
    List<Product> arr = [];

    for (Map<String, dynamic> i in json.decode(response.body)) {
      arr.add(Product.fromJson(i));
    }
    return arr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade300,  // Matching with app's primary theme
        title: Text(widget.title),
        centerTitle: true,
        elevation: 6,
      ),
      body: FutureBuilder<List<Product>>(
        future: getProducts(),
        builder: (context, projectSnap) {
          if (projectSnap.hasData) {
            if (projectSnap.data!.isEmpty) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'אין תוצאות',
                    style: TextStyle(fontSize: 23, color: Colors.black),
                  ),
                ),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: projectSnap.data!.length,
                      itemBuilder: (context, index) {
                        Product project = projectSnap.data![index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            onTap: () async {
                              final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                              await prefs.setInt('lastProductID', project.productID);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                    title: project.productName!,
                                  ),
                                ),
                              );
                            },
                            title: Text(
                              project.productName!,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey),
                            ),
                            subtitle: Text(
                              "${project.productPrice} ₪",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
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
                            isThreeLine: false,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          } else if (projectSnap.hasError) {
            return Center(
              child: Text(
                'שגיאה, נסה שוב',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
