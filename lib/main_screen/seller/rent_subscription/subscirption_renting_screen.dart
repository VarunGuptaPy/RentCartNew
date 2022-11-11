import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rent_cart/Widgets/subscription_card.dart';
import 'package:rent_cart/main_screen/seller/rent_subscription/subscription_add_screen.dart';
import 'package:rent_cart/models/subscription.dart';

import '../../../Widgets/item_card.dart';
import '../../../globals/globals.dart';
import '../../../models/items.dart';
import '../rent_book/item_add_screen.dart';

class SubscriptionRentingScreen extends StatefulWidget {
  final String? value;
  SubscriptionRentingScreen({this.value});
  @override
  State<SubscriptionRentingScreen> createState() =>
      _SubscriptionRentingScreenState();
}

class _SubscriptionRentingScreenState extends State<SubscriptionRentingScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: InkWell(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.cyan, Colors.amber],
                ),
              ),
              height: 60.0,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: const InkWell(
                child: Text(
                  "My Items",
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: "Signatra",
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
            child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => SubscriptionAddScreen(
                            value: widget.value,
                          )));
            },
            child: Text('Click to add new Item'),
          ),
        )),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('sellers')
              .doc(sharedPreferences!.getString('uid'))
              .collection('items')
              .where('type', isEqualTo: 'Rent Subscription')
              .snapshots(),
          builder: (context, snapshot) {
            return snapshot.hasData == false
                ? SliverToBoxAdapter(child: Text('No New Items'))
                : SliverStaggeredGrid.countBuilder(
                    crossAxisCount: 1,
                    staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                    itemBuilder: (context, index) {
                      Subscription model = Subscription.fromJson(
                          snapshot.data!.docs[index].data()!
                              as Map<String, dynamic>);
                      return SubscriptionCard(
                        model: model,
                        context: context,
                        type: 'seller',
                      );
                    },
                    itemCount: snapshot.data!.docs.length);
          },
        ),
      ],
    );
  }
}
