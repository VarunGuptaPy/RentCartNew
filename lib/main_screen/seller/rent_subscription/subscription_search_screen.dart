import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_cart/Widgets/subscription_card.dart';
import 'package:rent_cart/models/subscription.dart';

import '../../../globals/globals.dart';

class SubscriptionSearchScreen extends StatefulWidget {
  const SubscriptionSearchScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionSearchScreen> createState() =>
      _SubscriptionSearchScreenState();
}

class _SubscriptionSearchScreenState extends State<SubscriptionSearchScreen> {
  Future<QuerySnapshot>? restaurantDocumentList;
  String sellerNameText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.amber,
                Colors.cyan,
              ],
            ),
          ),
        ),
        title: TextField(
          onChanged: (value) {
            setState(() {
              sellerNameText = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search Restaurant',
            hintStyle: const TextStyle(
              color: Colors.white54,
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('sellers')
            .doc(sharedPreferences!.getString('uid'))
            .collection('items')
            .where('type', isEqualTo: 'Rent Subscription')
            .get(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    if (sellerNameText.isEmpty) {
                      var data = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      Subscription model = Subscription.fromJson(data);
                      return SubscriptionCard(
                        model: model,
                        context: context,
                      );
                    }
                    if (data['title']!
                        .toString()
                        .toLowerCase()
                        .startsWith(sellerNameText.toLowerCase())) {
                      Subscription model = Subscription.fromJson(data);
                      return SubscriptionCard(
                        model: model,
                        context: context,
                      );
                    } else {
                      return Container();
                    }
                  },
                )
              : const Center(
                  child: Text('No Result Found'),
                );
        },
      ),
    );
  }
}
