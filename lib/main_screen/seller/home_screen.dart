import 'package:flutter/material.dart';
import 'package:rent_cart/Widgets/seller_drawer.dart';
import 'package:rent_cart/globals/globals.dart';
import 'package:rent_cart/main_screen/seller/rent_book/Item_search_screen.dart';
import 'package:rent_cart/main_screen/seller/rent_book/book_renting_screen.dart';
import 'package:rent_cart/main_screen/seller/rent_subscription/subscirption_renting_screen.dart';
import 'package:rent_cart/main_screen/seller/rent_subscription/subscription_search_screen.dart';

class SellerHomeScreen extends StatefulWidget {
  @override
  State<SellerHomeScreen> createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
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
      drawer: const SellerDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.amber, Colors.cyan],
            ),
          ),
        ),
        title: Text(appName),
        actions: [
          DropdownButton(
            value: selectedValue,
            items: dropdownItems,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value!;
              });
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {
              if (selectedValue == 'Rent Subscription') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => SubscriptionSearchScreen()));
              } else if (selectedValue == 'Book Renting') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => ItemSearchScreen()));
              }
            },
          ),
        ],
      ),
      body: changeTo(selectedValue),
    );
  }
}

Widget? changeTo(selectedValue) {
  if (selectedValue == 'Book Renting') {
    return BookRentingScreen(
      value: selectedValue,
    );
  } else if (selectedValue == "Rent Subscription") {
    return SubscriptionRentingScreen(
      value: selectedValue,
    );
  }
}
