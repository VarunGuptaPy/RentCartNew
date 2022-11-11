import 'package:flutter/material.dart';
import 'package:rent_cart/main_screen/user/OrderScreen/Subscription_order_detail.dart';
import 'package:rent_cart/models/subscriptionOrder.dart';

class OrderScreenWidget extends StatefulWidget {
  SubscriptionOrder? model;
  OrderScreenWidget({this.model});
  @override
  State<OrderScreenWidget> createState() => _OrderScreenWidgetState();
}

class _OrderScreenWidgetState extends State<OrderScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (c) => SubscriptionOrderDetail(model: widget.model,)));
      },
      child: Column(
        children:  [
          const Divider(
            thickness: 4,
          ),
          ListTile(leading:Image.network(widget.model!.itemImage!),title: Text(widget.model!.itemTitle!),subtitle: Text(widget.model!.itemShortDescription!),),
          const Divider(
            thickness: 4,
          )
        ],
      ),
    );
  }
}
