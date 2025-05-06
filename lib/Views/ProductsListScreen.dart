import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/Product.dart';
import '../Utils/ClientConfing.dart';
import 'MyOrdersListScreen.dart';
import 'package:http/http.dart' as http;
import 'ProductDetailsScreen.dart';
class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key, required this.title});
  final String title;

  @override
  State<ProductsListScreen> createState() => _ProductsListScreen();
}
class _ProductsListScreen extends State<ProductsListScreen> {

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  Future getProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? lastCategoryID = prefs.getInt('lastCatID');
    var url = "products/getProducts.php?categoryID=" + lastCategoryID.toString();
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath + url);
    List<Product> arr = [];

    for(Map<String, dynamic> i in json.decode(response.body)){
      arr.add(Product.fromJson(i));
    }
    return arr;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: getProducts(),
        builder: (context, projectSnap) {
          if (projectSnap.hasData) {
            if (projectSnap.data.length == 0) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 2,
                child: Align(
                    alignment: Alignment.center,
                    child: Text('אין תוצאות',
                        style: TextStyle(fontSize: 23, color: Colors.black))),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: ListView.builder(
                        itemCount: projectSnap.data.length,
                        itemBuilder: (context, index) {
                          Product project = projectSnap.data[index];

                          return Card(
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
                                          title: project.productName,
                                        )),
                                  );
                                },
                                title: Text(
                                  project.productName!,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ), // Icon(Icons.timer),
                                subtitle: Text(
                                  project.productPrice!.toString() + "שח ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                trailing: Image.network(
                                  project.imageURL,
                                ),
                                isThreeLine: false,
                              ));
                        },
                      )),
                ],
              );
            }
          } else if (projectSnap.hasError) {
            print(projectSnap.error);
            return Center(
                child: Text('שגיאה, נסה שוב',
                    style:
                    TextStyle(fontSize: 22, fontWeight: FontWeight.bold)));
          }
          return Center(
              child: new CircularProgressIndicator(
                color: Colors.red,
              ));
        },
      ),
    );
  }
}