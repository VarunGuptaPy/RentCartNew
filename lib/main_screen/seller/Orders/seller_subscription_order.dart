import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_cart/Widgets/OrderScreenWidget.dart';
import 'package:rent_cart/globals/globals.dart';
import 'package:rent_cart/models/subscriptionOrder.dart';

class SellerSubscriptionOrder extends StatefulWidget {
  const SellerSubscriptionOrder({Key? key}) : super(key: key);

  @override
  State<SellerSubscriptionOrder> createState() => _SellerSubscriptionOrderState();
}

class _SellerSubscriptionOrderState extends State<SellerSubscriptionOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('sellers').doc(sharedPreferences!.getString('uid')).collection('orders').snapshots(),
        builder: (context, snapshot){
          return snapshot.hasData
              ? ListView.builder(itemCount: snapshot.data!.docs.length,itemBuilder: (context,index){
                SubscriptionOrder? model = SubscriptionOrder.fromJson(snapshot.data!.docs[index].data() as Map<String, dynamic>);
                return OrderScreenWidget(model: model,);
          },)
              : Container();
        },
      ),
    );
  }
}
