import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rent_cart/Widgets/my_drawer.dart';
import 'package:rent_cart/Widgets/subscription_home_row.dart';
import 'package:rent_cart/Widgets/user_Item_Card_Book.dart';
import 'package:rent_cart/main_screen/seller/rent_book/book_renting_screen.dart';
import 'package:rent_cart/main_screen/user/book_renting/Book_renting_Screen_User.dart';
import 'package:rent_cart/main_screen/user/item_search_screen_user.dart';
import 'package:rent_cart/main_screen/user/subscription_renting/subscription_home_screen.dart';
import 'package:rent_cart/models/items.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  String selectedValue = "Book Renting";
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Book Renting", child: Text("Book Renting")),
      const DropdownMenuItem(
          value: "Rent Subscription", child: Text("Rent Subscription")),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.cyan, Colors.amber])),
        ),
        title: Text(
          'Rent Cart',
          style: TextStyle(fontSize: 40, fontFamily: "Signatra"),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {
              if (selectedValue == 'Rent Subscription') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => ItemSearchScreenUser(value: 'Rent Subscription',)));
              } else if (selectedValue == 'Book Renting') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => ItemSearchScreenUser(value: "Book Renting",)));
              }
            },
          ),
          DropdownButton(
            value: selectedValue,
            items: dropdownItems,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value!;
              });
            },
          ),
        ],
      ),
      body: ScreenToGo(selectedValue),
    );
  }
}

Widget ScreenToGo(value) {
  if (value == "Book Renting") {
    return BookRentingScreenUser();
  } else {
    return SubscriptionHomeScreen();
  }
}
