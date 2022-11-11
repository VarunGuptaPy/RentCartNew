import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_cart/Widgets/subscription_home_row.dart';
import 'package:what3words/what3words.dart';

class SubscriptionHomeScreen extends StatefulWidget {

  @override
  State<SubscriptionHomeScreen> createState() => _SubscriptionHomeScreenState();
}

class _SubscriptionHomeScreenState extends State<SubscriptionHomeScreen> {
  List<dynamic> SubscriptionType = [];
  List<dynamic> stream = [];
  List<dynamic> design = [];
  List<dynamic> study = [];
  List<dynamic> vpn = [];
  List<dynamic> music = [];
  List<dynamic> business= [];
  List<dynamic> adult = [];
  List<dynamic> others = [];
  @override
  void initState() {
    FirebaseFirestore.instance.collection('BookTypes').doc('SubscriptionType').get().then((value){
      setState((){
        SubscriptionType = value.data()!['Types'];
        stream = value.data()!['stream'];
        design = value.data()!['design'];
        study = value.data()!['study'];
        vpn = value.data()!['vpn'];
        music = value.data()!['music'];
        business = value.data()!['business'];
        adult = value.data()!['adult'];
        others = value.data()!['others'];
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 800,
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(itemCount: SubscriptionType.length,itemBuilder: (context, index){
                String value = SubscriptionType[index].toString();
                if (value == 'stream'){
                  return SubscriptionHomeRow(typeOfRent: 'Rent Subscription',value: value,ItemList: stream,type: 'Subscription',);
                }
                else if (value == 'design'){
                  return SubscriptionHomeRow(typeOfRent: 'Rent Subscription',value: value,ItemList: design,type: 'Subscription',);
                }
                else if (value == 'study'){
                  return SubscriptionHomeRow(typeOfRent: 'Rent Subscription',value: value,ItemList: study,type: 'Subscription',);
                }
                else if (value == 'vpn'){
                  return SubscriptionHomeRow(typeOfRent: 'Rent Subscription',value: value,ItemList: vpn,type: 'Subscription',);
                }
                else if (value == 'music'){
                  return SubscriptionHomeRow(typeOfRent: 'Rent Subscription',value: value,ItemList: music,type: 'Subscription',);
                }
                else if (value == 'business'){
                  return SubscriptionHomeRow(typeOfRent: 'Rent Subscription',value: value,ItemList: business,type: 'Subscription',);
                }
                else if (value == 'adult'){
                  return SubscriptionHomeRow(typeOfRent: 'Rent Subscription',value: value,ItemList: adult,type: 'Subscription',);
                }
                else if (value == 'others'){
                  return SubscriptionHomeRow(typeOfRent: 'Rent Subscription',value: value,ItemList: others,type: 'Subscription',);
                }
                else{
                  return Container();
                }
              },),
            )
          ],
        ),
      ),
    );
  }
}
