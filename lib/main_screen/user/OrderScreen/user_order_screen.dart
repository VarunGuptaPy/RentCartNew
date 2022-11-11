import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_cart/globals/globals.dart';
import 'package:rent_cart/main_screen/user/OrderScreen/Subscription_Order_Screen.dart';
class UserOrderScreen extends StatefulWidget {
  const UserOrderScreen({Key? key}) : super(key: key);

  @override
  State<UserOrderScreen> createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber,Colors.cyan],
              )
            ),
          ),
          centerTitle: true,
          title: const Text(
            'My Orders',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.book),
                text: 'Book Renting',
              ),
              Tab(
                icon: Icon(Icons.subscriptions),
                text: 'Rent Subscription',
              )
            ],
            indicatorColor: Colors.white30,
            indicatorWeight: 6,
          ),
        ),
        body: TabBarView(
          children: [Container(),SubscriptionOrderScreen()],
        ),
      ),
    );
  }
}
