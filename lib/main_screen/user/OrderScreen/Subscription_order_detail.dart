import 'package:flutter/material.dart';
import 'package:rent_cart/models/subscriptionOrder.dart';

class SubscriptionOrderDetail extends StatefulWidget {
  SubscriptionOrder? model;

  SubscriptionOrderDetail({this.model});

  @override
  State<SubscriptionOrderDetail> createState() =>
      _SubscriptionOrderDetailState();
}

class _SubscriptionOrderDetailState extends State<SubscriptionOrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model!.itemTitle!),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.amber, Colors.cyan],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Text('status: ' + widget.model!.status!,style: TextStyle(fontSize: 25),),
          SizedBox(height: 10,),
          Image.network(widget.model!.itemImage!),
          SizedBox(height: 10,),
          Text(widget.model!.itemTitle!,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Text('Expires at ' + widget.model!.OrderEnd!.toDate().toString(),style: TextStyle(fontSize: 20),),
          SizedBox(height: 10,),
          Text('Ordered at ' + widget.model!.OrderPlacedAt!.toDate().toString(),style: TextStyle(fontSize: 20),),
        ],
      ),
    );
  }
}
