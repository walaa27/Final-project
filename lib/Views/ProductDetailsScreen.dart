import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/Product.dart';
import '../Utils/ClientConfing.dart';


// final String recipeID;

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.title});

  final String title;
  // final String recipeID;

  @override
  State<ProductDetailsScreen> createState() => ProductPageState();
}


class ProductPageState extends State<ProductDetailsScreen> {


  final _txtUserName = TextEditingController();

  // late final String recipeID;
  late Product _currProduct;


  Future<void> getDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? lastProductID = prefs.getInt('lastProductID');

    var url = "products/getProductDetails.php?productID=$lastProductID";
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath + url);
    // Map<String, dynamic> i in json.decode(response.body)
    _currProduct = Product.fromJson(json.decode(response.body));
    setState(() {


    });
  }


  @override
  Widget build(BuildContext context) {
    getDetails();


    return Scaffold(
      appBar: AppBar(
        title: Text("פרטי המוצר", style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 6,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,


              children: [


                Center(
                  child:
                  Image.network(_currProduct.imageURL),

                ),


                const SizedBox(height: 20),
                Text(
                  _currProduct.productName, style: const TextStyle(fontSize: 22,
                    fontWeight: FontWeight.w300, color: Colors.blueGrey),
                ),


                const SizedBox(height: 10),
                const Text("price: ",
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                ),


                Text(_currProduct.productPrice.toString()),


                const SizedBox(height: 10),
                Divider(thickness: 1, color: Colors.grey.shade400),
                const SizedBox(height: 10),



                // Add to Cart Button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add to cart logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Added to cart!')),
                      );
                    },

                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
