import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent_cart/Widgets/subscritption_view_widget.dart';
import 'package:rent_cart/models/UserSubscription.dart';

class SubscriptionHomeRow extends StatefulWidget {
  final String? value;
  final String? typeOfRent;
  final List<dynamic>? ItemList;
  final String? type;
  SubscriptionHomeRow({this.value,this.typeOfRent,this.ItemList,this.type});

  @override
  State<SubscriptionHomeRow> createState() => _SubscriptionHomeRowState();
}

class _SubscriptionHomeRowState extends State<SubscriptionHomeRow> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Best Seller in ${widget.value}',
          style: TextStyle(
            fontFamily: 'Signatra',
            fontSize: 30,
          ),
        ),
        Container(
          height: 220,
          child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: widget.ItemList!.length,itemBuilder: (context,index){
              if (widget.ItemList![index]['status'] == 'available'){
                return SubscriptionViewWidget(data: widget.ItemList![index],type: widget.type,);
              }
              else {
                return Container();
              }
          },),
        )
      ],
    );
  }
}
