import 'package:flutter/material.dart';
import 'package:rent_cart/models/UserSubscription.dart';
import 'package:rent_cart/models/subscription.dart';

class GetPassword extends StatefulWidget {
  UserSubscription? model;
  
  GetPassword({this.model});

  @override
  State<GetPassword> createState() => _GetPasswordState();
}

class _GetPasswordState extends State<GetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.amber, Colors.cyan,],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Text('email : ${widget.model!.subscriptionEmail}',style: TextStyle(fontSize: 20),),
          Text('password : ${widget.model!.password}',style: TextStyle(fontSize: 20),),
        ],
      ),
    );
  }
}
