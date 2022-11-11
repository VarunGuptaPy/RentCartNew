import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_cart/main_screen/user/subscription_renting/subscription_detail_screen.dart';
import 'package:rent_cart/models/UserSubscription.dart';
import 'package:rent_cart/models/items.dart';

import 'item_detail_screen_user.dart';

class SubscriptionViewWidget extends StatefulWidget {
  Map<String, dynamic>? data;
  String? type;

  SubscriptionViewWidget({this.data, this.type});

  @override
  State<SubscriptionViewWidget> createState() => _SubscriptionViewWidgetState();
}

class _SubscriptionViewWidgetState extends State<SubscriptionViewWidget> {
  var model;

  @override
  void initState() {
    super.initState();
    if (widget.type == 'Subscription') {
      model = UserSubscription.fromJson(widget.data!);
    } else {
      model = Items.fromJson(widget.data!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: InkWell(
        onTap: () {
          if (widget.type == 'Subscription') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => SubscriptionDetailScreen(
                  model: model,
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => ItemDetailScreenUser(
                  model: model,
                ),
              ),
            );
          }
        },
        child: Container(
          decoration: const BoxDecoration(
              border: Border(
            top: BorderSide(
              width: 4,
              color: Colors.black,
              style: BorderStyle.solid,
            ),
            bottom: BorderSide(
              width: 4,
              color: Colors.black,
              style: BorderStyle.solid,
            ),
            left: BorderSide(
              width: 4,
              color: Colors.black,
              style: BorderStyle.solid,
            ),
            right: BorderSide(
              width: 4,
              color: Colors.black,
              style: BorderStyle.solid,
            ),
          )),
          child: Column(
            children: [
              Image.network(
                model!.thumbnailUrl!,
                height: 100,
              ),
              Text(
                model!.title!,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '₹' + model!.SingleDayRent!.toString() + '/day',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
