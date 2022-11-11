import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_cart/models/bookOrder.dart';

import '../../../globals/globals.dart';

class BookOrder extends StatefulWidget {
  const BookOrder({Key? key}) : super(key: key);

  @override
  State<BookOrder> createState() => _BookOrderState();
}

class _BookOrderState extends State<BookOrder> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(sharedPreferences!.getString('uid'))
          .collection('orders')
          .where('itemType', isEqualTo: 'Book Renting',)
          .snapshots(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemBuilder: (context, index) {
                  BookOrders? model = BookOrders.fromJson(snapshot.data!.docs[index].data() as Map<String, dynamic>);
                  return Container();
                },
                itemCount: snapshot.data!.docs.length,
              )
            : Container();
      },
    );
  }
}
