import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> books = [

  ];
  List<String> filteredBooks = [];

  @override
  void initState() {
    super.initState();
    filteredBooks = books; // Show all books initially
  }

  void _filterBooks(String query) {
    setState(() {
      filteredBooks = books
          .where((book) => book.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Books"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search for a book...",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterBooks,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredBooks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredBooks[index]),
                    leading: Icon(Icons.book),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}