import 'package:flutter/material.dart';

class Searchs extends StatefulWidget {
  const Searchs({super.key, required this.title});


  final String title;

  State<Searchs> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<Searchs> {
  TextEditingController _searchController = TextEditingController();
  List<String> products = [];
  List<String> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = products; // Show all products initially
  }

  void _filterProduct(String query) {
    setState(() {
      filteredProducts = products
          .where((product) => product.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(":חיפוש מוצר"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "לחפש מוצר...",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterProduct,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredProducts[index]),
                    leading: Icon(Icons.shopping_cart),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }}