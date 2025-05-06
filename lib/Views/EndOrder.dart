import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/Product.dart';
import '../Utils/ClientConfing.dart';
import 'package:http/http.dart' as http;

class Endorder extends StatefulWidget {
  final String userName;
  final List<Product> cartItems;
  final double totalPrice;
  const Endorder({
    Key? key,
    required this.userName,
    required this.cartItems,
    required this.totalPrice,
  }) : super(key: key);

  @override
  State<Endorder> createState() => _EndorderState();
}

class _EndorderState extends State<Endorder> {
  final TextEditingController notesController = TextEditingController();
  late String? _FirstName = "";
  late String? _LastName = "";

  Future insertOrder(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userID = prefs.getString("userID");
    var url = "orders/insertOrder.php?userID=" + userID! +
        "&totalPrice=" + widget.totalPrice.toStringAsFixed(2) + "&notes=" + notesController.text;
    final response = await http.get(Uri.parse(serverPath + url));
    print(serverPath + url);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('הזמנה בוצעה בהצלחה!')),
    );
    Navigator.pop(context);
    Navigator.pop(context);

  }
  getMyDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _FirstName = prefs.getString("FirstName");
    _LastName = prefs.getString("LastName");
    setState(() {});

  }
    @override
  Widget build(BuildContext context) {
    getMyDetails();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: Colors.blue.shade800,
          title: Text(
            "פרטי ההזמנה",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Text(
                'שם הלקוח: ${_FirstName! + " " + _LastName!}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'פרטי מוצרים:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade700,
                ),
              ),
              SizedBox(height: 10),
              ...widget.cartItems.map(
                    (item) => Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // السعر - أوضح وأكبر
                        Text(
                          '${item.productPrice?.toStringAsFixed(2) ?? '0'} ש"ח',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),

                        // اسم المنتج - أصغر شوي وبشكل مرتب
                        Flexible(
                          child: Text(
                            item.productName ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(thickness: 2),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'סה"כ לתשלום: ${widget.totalPrice.toStringAsFixed(2)} ש"ח',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'הערות (מיקום, זמן אספקה...)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              TextField(
                controller: notesController,
                decoration: InputDecoration(
                  hintText: 'כתוב כאן...',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 3,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    print('הוזן הערות: ${notesController.text}');
                    // إرسال الطلب هنا
                    insertOrder(context);
                  },
                  child: Text(
                    "אישור הזמנה",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
