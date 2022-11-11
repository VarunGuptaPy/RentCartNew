import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_cart/globals/globals.dart';
import 'package:rent_cart/main_screen/seller/rent_book/item_detail_screen.dart';
import 'package:rent_cart/main_screen/seller/rent_subscription/subscription_Item_detail_Screen.dart';
import 'package:rent_cart/models/subscription.dart';

import '../models/items.dart';

class SubscriptionCard extends StatefulWidget {
  final Subscription? model;
  final BuildContext? context;
  final String? type;
  SubscriptionCard({this.type,this.model, this.context,});

  @override
  _SubscriptionCardState createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => SubscriptionItemDetailScreen(
                      model: widget.model,
                    )));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Container(
          height: 330,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Image.network(
                  widget.model!.thumbnailUrl.toString(),
                  height: 200,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.model!.title!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: "Train",
                      color: Colors.cyan,
                    ),
                  ),
                    widget.type == 'seller'
                      ? IconButton(onPressed: (){
                      FirebaseFirestore.instance.collection('items').doc(widget.model!.itemID).delete();
                      FirebaseFirestore.instance.collection('sellers').doc(sharedPreferences!.getString('uid')).collection('items').doc(widget.model!.itemID).delete();
                    }, icon: Icon(Icons.delete,color: Colors.pink,))
                      : Container(),
                ],
              ),
              // IconButton(
              //   icon: Icon(
              //     Icons.delete,
              //     color: Colors.pinkAccent,
              //   ),
              //   onPressed: () async {
              //     await FirebaseFirestore.instance
              //         .collection('sellers')
              //         .doc(sharedPreferences!.getString('uid'))
              //         .collection('items')
              //         .doc(widget.model!.itemID)
              //         .delete();
              //     await FirebaseFirestore.instance
              //         .collection('items')
              //         .doc(widget.model!.itemID)
              //         .delete();
              //   },
              // ),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
