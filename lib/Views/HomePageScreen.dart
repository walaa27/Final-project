import 'package:final_project/Views/EditProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'ShoppingCart.dart';
class Homepagescreen extends StatefulWidget {
  const Homepagescreen({super.key, required this.title});

  final String title;

  @override
  State<Homepagescreen> createState() => _Homepagescreen();
}

class _Homepagescreen extends State<Homepagescreen> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: ראשי',
      style: optionStyle,
    ),
    Text(
      'Index 1: חיפוש',
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(100, (index) {
          return Center(
            child: Text(
              'Item $index',
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineSmall,
            ),
          );
        }),
      ),

        bottomNavigationBar: Container(
            color: Colors.white,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
                child: GNav(
                    backgroundColor: Colors.white,
                    color: Colors.pinkAccent,
                    activeColor: Colors.pinkAccent,
                    tabBackgroundColor: Colors.grey.shade800,
                    padding: EdgeInsets.all(16),
                    gap: 8,
                    tabs: [
                      GButton(
                        icon: Icons.home,
                        text: "Home",

                      ),
                      GButton(
                          icon: Icons.shopping_basket,
                          text: "My Basket",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Shoppingcart(
                                  ),
                                )

                            );
                          }

                      ),

                    ]
                )
            )
        )
    );
  }
}