import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:rent_cart/Widgets/add_address_screen.dart';
import 'package:rent_cart/globals/globals.dart';
import 'package:rent_cart/models/address.dart';

import '../../../../Widgets/address_design.dart';
import '../../../../Widgets/progress_bar.dart';
import '../../../../models/items.dart';
import '../../../../providers/address_changer.dart';

class BookBuying_step2 extends StatefulWidget {
  final TextEditingController? week;
  final TextEditingController? month;
  final TextEditingController? day;
  final Items? model;
  BookBuying_step2({this.week,this.month,this.day,this.model});

  @override
  State<BookBuying_step2> createState() => _BookBuying_step2State();
}

class _BookBuying_step2State extends State<BookBuying_step2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Shipment 2 of 3',
            style: TextStyle(
              fontSize: 30,
              fontFamily: "Signatra",
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.amber,
                Colors.cyan,
              ]),
            ),
          ),
          centerTitle: true,
        ),
        body: Column(children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Select Address',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(sharedPreferences!.getString('uid'))
                  .collection('address')
                  .snapshots(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Container(
                  height: 200,
                  width: 400,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                        Address model = Address.fromJson(data);
                        return AddressDesign(
                          model: model,
                          month: int.parse(widget.month!.text),
                          week: int.parse(widget.week!.text),
                          day: int.parse(widget.day!.text),
                          itemsModel: widget.model,
                          sellerUID: widget.model!.sellerUID,
                        );
                      }),
                )
                    : Text("NO Address Found");
              }),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => AddAddressScreen(),
                  ),
                );
              },
              child: Text('Add address')),

        ]));
  }
}
