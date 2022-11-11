import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:rent_cart/main_screen/user/subscription_renting/shipment/shipment_step2.dart';
import 'package:rent_cart/models/UserSubscription.dart';

class Shipment extends StatefulWidget {
  final UserSubscription? model;

  Shipment({this.model});

  @override
  State<Shipment> createState() => _ShipmentState();
}

class _ShipmentState extends State<Shipment> {
  TextEditingController? dayController = TextEditingController();
  TextEditingController? weekController = TextEditingController();
  TextEditingController? monthController = TextEditingController();
  var value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan, Colors.amber],
            ),
          ),
        ),
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
                  builder: (c) => ShipmentStep2(
                    model: widget.model,
                    month: int.parse(monthController!.text),
                    week: int.parse(weekController!.text),
                    day: int.parse(dayController!.text),
                  ),
                ),
              );
            },
            child: Text('Proceed for payment'),
            style: ElevatedButton.styleFrom(
              primary: Colors.amber,
            ),
          )
        ],
      ),
    );
  }
}
