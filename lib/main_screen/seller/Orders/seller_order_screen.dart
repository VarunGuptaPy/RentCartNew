import 'package:flutter/material.dart';
import 'package:rent_cart/main_screen/seller/Orders/seller_subscription_order.dart';

class SellerOrderScreen extends StatefulWidget {
  const SellerOrderScreen({Key? key}) : super(key: key);

  @override
  State<SellerOrderScreen> createState() => _SellerOrderScreenState();
}

class _SellerOrderScreenState extends State<SellerOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'New Orders',
            style: TextStyle(fontSize: 30),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.amber, Colors.cyan],
            )),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.book),text: 'Book Renting',),
              Tab(icon: Icon(Icons.subscriptions),text: 'Subscription Renting',)
            ],
          ),
        ),
        body: TabBarView(children: [Container(),SellerSubscriptionOrder()],),
      ),
    );
  }
}
