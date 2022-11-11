import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_cart/Widgets/error_dialog.dart';
import 'package:rent_cart/globals/globals.dart';
import 'package:rent_cart/main_screen/user/home_screen.dart';
import 'package:rent_cart/models/address.dart';
import 'package:upi_india/upi_india.dart';
import 'dart:math';
import '../../../../models/items.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
class BookBuyingStep3 extends StatefulWidget {
  Address? addressModel;
  Items? itemsModel;
  String? sellerUid;
  int? week;
  int? month;
  int? day;

  BookBuyingStep3(
      {this.addressModel, this.itemsModel, this.sellerUid, this.week,this.month,this.day});

  @override
  State<BookBuyingStep3> createState() => _BookBuyingStep3State();
}

class _BookBuyingStep3State extends State<BookBuyingStep3> {
  UpiIndia upi = UpiIndia();
  List<UpiApp>? apps;
  String? sellerUpi;
  String? sellerUpiName;
  String? sellerWhat3Words;
  String? sellerUID;
  int? phone;
  Map<String, dynamic>? paymentIntent;
  final SECRET_KEY =
      'sk_test_51K1qZsSImF7xw0PtzpODfQoffmvt0WWIrZdiaRvBBUGvOA5a8w3keAU6rPO4Zs4kRmr9VOvjg0N5EmAci5kFqpRx00D2lDjLDt';
  Razorpay? _razorpay;
  var lat;
  var lng;
  List itemList = [];
  int? totalPrice;
  @override
  void initState() {

    super.initState();
    FirebaseFirestore.instance.collection('BookTypes').doc('BookType').get().then((value){
      itemList = value.data()![widget.itemsModel!.itemType];
    });
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    setState((){
      totalPrice = (widget.month! * widget.itemsModel!.SingleMonthRent!.toInt()) + (widget.week! * widget.itemsModel!.SingleWeekRent!.toInt()) + (widget.day! * widget.itemsModel!.SingleDayRent!.toInt()) +  15;
    });
    FirebaseFirestore.instance.collection('sellers').doc(widget.itemsModel!.sellerUID).get().then((value){
      lat = value.data()!['lat'];
      lng = value.data()!['lng'];
      phone = value.data()!['phone'];
      sellerWhat3Words = value.data()!['what3words'];
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async  {
    {
      Fluttertoast.showToast(msg: 'You payment is successful');
      String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
      await FirebaseFirestore.instance.collection('orders').doc(uniqueName).set({
        'orderID': uniqueName,
        'userName': widget.addressModel!.name,
        'userPhoneNumber': widget.addressModel!.phoneNumber,
        'OrderTime':Timestamp.now(),
        'sellerPhoneNumber': phone,
        'orderStatus': 'placed',
        'receiver': 'user',
        'giver': 'seller',
        'userWhat3Words': widget.addressModel!.what3word,
        'sellerWhat3Words': sellerWhat3Words,
        'sellerLat': lat,
        'sellerLng': lng,
        'itemType':'Book Renting',
        'userLat' : widget.addressModel!.lat,
        'userLng' : widget.addressModel!.lng,
        'distanceBetween': calculateDistance(
          widget.addressModel!.lat,
          widget.addressModel!.lng,
          lat,
          lng,
        ),
      });
      await FirebaseFirestore.instance.collection('sellers').doc(widget.itemsModel!.sellerUID).collection('orders').doc(uniqueName).set({
        'orderID': uniqueName,
        'userName': widget.addressModel!.name,
        'userPhoneNumber': widget.addressModel!.phoneNumber,
        'sellerPhoneNumber': phone,
        'OrderTime':Timestamp.now(),
        'orderStatus': 'placed',
        'receiver': 'user',
        'giver': 'seller',
        'userWhat3Words': widget.addressModel!.what3word,
        'sellerWhat3Words': sellerWhat3Words,
        'sellerLat': lat,
        'itemType':'Book Renting',
        'sellerLng': lng,
        'userLat' : widget.addressModel!.lat,
        'userLng' : widget.addressModel!.lng,
        'distanceBetween': calculateDistance(
          widget.addressModel!.lat,
          widget.addressModel!.lng,
          lat,
          lng,
        ),
      });
      await FirebaseFirestore.instance.collection('users').doc(sharedPreferences!.getString('uid')).collection('orders').doc(uniqueName).set({
        'orderID': uniqueName,
        'userName': widget.addressModel!.name,
        'userPhoneNumber': widget.addressModel!.phoneNumber,
        'sellerPhoneNumber': phone,
        'OrderTime':Timestamp.now(),
        'orderStatus': 'placed',
        'receiver': 'user',
        'giver': 'seller',
        'userWhat3Words': widget.addressModel!.what3word,
        'sellerWhat3Words': sellerWhat3Words,
        'sellerLat': lat,
        'itemType':'Book Renting',
        'sellerLng': lng,
        'userLat' : widget.addressModel!.lat,
        'userLng' : widget.addressModel!.lng,
        'distanceBetween': calculateDistance(
          widget.addressModel!.lat,
          widget.addressModel!.lng,
          lat,
          lng,
        ),
      });
      for(var i in itemList){
        if (i['itemID'] == widget.itemsModel!.itemID){
          i['status'] = 'not available';
          await FirebaseFirestore.instance.collection('BookTypes').doc('SubscriptionType').update({
            widget.itemsModel!.itemType!: itemList,
          });
          break;
        }
      }
      await FirebaseFirestore.instance.collection('BookTypes').doc('BookType').update(
          {
            widget.itemsModel!.itemType!: itemList,
          });
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => MyHomeScreen()));
      Fluttertoast.showToast(msg: 'Your order has been successfully placed');
    }
  }
  Future<void> makePayment(amount) async {
    var realAmount = calculateAmount(amount);
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('rzp_test_nyhzf649Zjgxa0:SSH5lLlERGjaYOZ8FqlaI9HJ'));
    final body = jsonEncode({
      'amount': realAmount,
      'currency': 'INR',
    });
    var response = await http.post(Uri.parse('https://api.razorpay.com/v1/orders'),headers: {
      'Authorization': basicAuth,
      'Content-Type': 'application/json'
    },body: body,);
    String orderId = jsonDecode(response.body)['id'];
    var options = {
      'key': 'rzp_test_nyhzf649Zjgxa0',
      'amount': int.parse(realAmount),
      'order_id': orderId,
      'name' : 'RentCart',
      'description': 'Renting facility',
      'timeout': 300,

    };
    _razorpay!.open(options);
    // var response = await http.post(
    //   Uri.parse('https://api.stripe.com/v1/payment_intents'),
    //   headers: {
    //     'Authorization': 'Bearer $SECRET_KEY',
    //     'Content-Type': 'application/x-www-form-urlencoded'
    //   },
    //   body: body,
    // );
  }
  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.amber,
                  Colors.cyan,
                ],
              ),
            ),
          ),
          title: Text(
            'Shipment 3 of 3',
            style: TextStyle(
              fontSize: 40,
              fontFamily: 'Signatra',
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Total Price : ₹$totalPrice',
                style: GoogleFonts.dancingScript(fontSize: 30),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Total Delivery: ₹15 (Cash)',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Total Delivery When book is returned (online): ₹15',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    makePayment('${totalPrice}');
                  },
                  child: Text('Pay'))
            ],
          ),
        ));
  }

  _handlePaymentError() {
  }

  _handleExternalWallet() {
  }
}
