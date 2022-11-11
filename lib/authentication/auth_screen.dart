import 'package:flutter/material.dart';
import 'package:rent_cart/authentication/seller/sellerAuth.dart';
import 'package:rent_cart/authentication/user/userAuth.dart';

class MyAuthScreen extends StatefulWidget {
  const MyAuthScreen({Key? key}) : super(key: key);
  @override
  State<MyAuthScreen> createState() => _MyAuthScreenState();
}

class _MyAuthScreenState extends State<MyAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan, Colors.amber],
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          title: const Text(
            "RentCart",
            style: TextStyle(
              fontSize: 60,
              color: Colors.white,
              fontFamily: "Lobster",
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.supervised_user_circle_outlined),
                text: 'User',
              ),
              Tab(
                icon: Icon(Icons.sell_outlined),
                text: 'Seller',
              )
            ],
            indicatorColor: Colors.white30,
            indicatorWeight: 6,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.amber, Colors.cyan],
            ),
          ),
          child: TabBarView(
            children: [userAuth(), sellerAuth()],
          ),
        ),
      ),
    );
  }
}
