import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_cart/Widgets/item_card.dart';
import 'package:rent_cart/Widgets/subscription_card.dart';
import 'package:rent_cart/models/items.dart';
import 'package:rent_cart/models/subscription.dart';

import '../../../globals/globals.dart';

class ItemSearchScreen extends StatefulWidget {
  const ItemSearchScreen({Key? key}) : super(key: key);

  @override
  State<ItemSearchScreen> createState() => _ItemSearchScreenState();
}

class _ItemSearchScreenState extends State<ItemSearchScreen> {
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
          decoration: const InputDecoration(
            hintText: 'Search Restaurant',
            hintStyle: TextStyle(
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
            .where('type', isEqualTo: 'Book Renting')
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
                      Items model = Items.fromJson(data);
                      return ItemCard(
                        model: model,
                        context: context,
                      );
                    }
                    if (data['title']!
                        .toString()
                        .toLowerCase()
                        .startsWith(sellerNameText.toLowerCase())) {
                      Items model = Items.fromJson(data);
                      return ItemCard(
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
