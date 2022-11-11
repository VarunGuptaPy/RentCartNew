import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_cart/main_screen/user/subscription_renting/shipment/shipment.dart';
import 'package:rent_cart/models/UserSubscription.dart';
import 'package:what3words/what3words.dart';

class SubscriptionDetailScreen extends StatefulWidget {
  UserSubscription? model;
  SubscriptionDetailScreen({this.model});

  @override
  State<SubscriptionDetailScreen> createState() => _SubscriptionDetailScreenState();
}

class _SubscriptionDetailScreenState extends State<SubscriptionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan,Colors.amber],
            )
          ),
        ),
        title: Text(widget.model!.title!,style: GoogleFonts.playfairDisplay(fontSize: 20),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.model!.thumbnailUrl!,height: 300,),
            Row(children: [Text('₹${widget.model!.SingleDayRent}/Day',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),Text('₹${widget.model!.SingleWeekRent}/Week',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),Text('₹${widget.model!.SingleMonthRent}/Month',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)],mainAxisAlignment: MainAxisAlignment.spaceEvenly,),
            SizedBox(height: 20,),
            Text(widget.model!.title!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text(widget.model!.LongDescription!),
            SizedBox(height: 20,),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (c) => Shipment(model: widget.model,)));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.amber,
                        Colors.cyan,
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Place Order",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
