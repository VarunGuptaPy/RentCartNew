import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_cart/Widgets/OrderScreenWidget.dart';
import 'package:rent_cart/globals/globals.dart';
import 'package:rent_cart/models/subscriptionOrder.dart';

class SubscriptionOrderScreen extends StatefulWidget {
  const SubscriptionOrderScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionOrderScreen> createState() =>
      _SubscriptionOrderScreenState();
}

class _SubscriptionOrderScreenState extends State<SubscriptionOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(sharedPreferences!.getString('uid'))
          .collection('orders')
          .where('itemType',isEqualTo: 'Rent Subscription')
          .snapshots(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  SubscriptionOrder? model = SubscriptionOrder.fromJson(
                      snapshot.data!.docs[index].data()
                          as Map<String, dynamic>);
                  return OrderScreenWidget(
                    model: model,
                  );
                },
              )
            : Container();
      },
    );
  }
}
