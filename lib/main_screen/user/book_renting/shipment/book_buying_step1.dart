import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:rent_cart/globals/globals.dart';
import 'package:rent_cart/main_screen/user/book_renting/shipment/book_buying_step2.dart';
import 'package:rent_cart/main_screen/user/book_renting/shipment/book_buying_step3.dart';
import 'package:rent_cart/main_screen/user/book_renting/shipment/daily_shipping.dart';
import 'package:rent_cart/main_screen/user/book_renting/shipment/monthly_shipping.dart';
import 'package:rent_cart/main_screen/user/book_renting/shipment/weekly_shipping.dart';
import 'package:rent_cart/models/address.dart';
import '../../../../Widgets/add_address_screen.dart';
import '../../../../Widgets/address_design.dart';
import '../../../../authentication/seller/sellerAuth.dart';
import '../../../../authentication/user/userAuth.dart';
import '../../../../models/items.dart';

class BookBuyingStep1 extends StatefulWidget {
  final Items? model;

  BookBuyingStep1({this.model});

  @override
  State<BookBuyingStep1> createState() => _BookBuyingStep1State();
}

class _BookBuyingStep1State extends State<BookBuyingStep1> {
  TextEditingController? dayController = TextEditingController();
  TextEditingController? weekController = TextEditingController();
  TextEditingController? monthController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.amber, Colors.cyan]),
            ),
          ),
          title: Text(
            'Shipment 1 of 3',
            style: TextStyle(fontFamily: 'Signatra', fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Month',
                      style: TextStyle(fontSize: 30),
                    ),
                    Container(
                      child: NumberInputPrefabbed.roundedButtons(
                        controller: monthController!,
                        min: 1,
                      ),
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Week',
                      style: TextStyle(fontSize: 30),
                    ),
                    Container(
                      child: NumberInputPrefabbed.roundedButtons(
                        controller: weekController!,
                        min: 1,
                      ),
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'day',
                      style: TextStyle(fontSize: 30),
                    ),
                    Container(
                      child: NumberInputPrefabbed.roundedButtons(
                        controller: dayController!,
                        min: 1,
                      ),
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => BookBuying_step2(model: widget.model,month: monthController,week: weekController,day: dayController,),
                    ),
                  );
                },
                child: Text('Next')),
          ]
        ),
      ),
    );
  }
}
