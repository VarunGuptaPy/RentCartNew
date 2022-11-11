import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rent_cart/globals/globals.dart';
import 'package:rent_cart/models/UserSubscription.dart';

class ShipmentStep2 extends StatefulWidget {
  final int? month;
  final int? week;
  final int? day;
  final UserSubscription? model;
  ShipmentStep2({this.month, this.week, this.day, this.model});

  @override
  State<ShipmentStep2> createState() => _ShipmentStep2State();
}

class _ShipmentStep2State extends State<ShipmentStep2> {
  Map<String, dynamic>? paymentIntent;
  final SECRET_KEY =
      'sk_test_51K1qZsSImF7xw0PtzpODfQoffmvt0WWIrZdiaRvBBUGvOA5a8w3keAU6rPO4Zs4kRmr9VOvjg0N5EmAci5kFqpRx00D2lDjLDt';
  Razorpay? _razorpay;
  int? totalDays;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    totalDays = widget.day! + (widget.month! * 30) + (widget.week! * 7);

  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: 'You payment is successful');
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
    await FirebaseFirestore.instance.collection('orders').doc(uniqueName).set({
      'OrderID': uniqueName,
      'OrderPlacedAt': DateTime.now(),
      'OrderEnd': DateTime.now().add(Duration(days: totalDays!)),
      'sellerUID': widget.model!.sellerUID,
      'userUID': sharedPreferences!.getString('uid'),
      'itemImage': widget.model!.thumbnailUrl,
      'itemTitle': widget.model!.title,
      'itemShortDescription': widget.model!.shortInfo,
      'ItemUID': widget.model!.itemId,
      'totalAmount': ((widget.day! * widget.model!.SingleDayRent!) + (widget.month! * widget.model!.SingleWeekRent!) + (widget.month! * widget.model!.SingleMonthRent!)),
      'status': 'placed',
      'itemType': 'Rent Subscription',
    });
      await FirebaseFirestore.instance.collection('sellers').doc(widget.model!.sellerUID).collection('orders').doc(uniqueName).set({
        'OrderID': uniqueName,
        'OrderPlacedAt': DateTime.now(),
        'OrderEnd': DateTime.now().add(Duration(days: totalDays!)),
        'sellerUID': widget.model!.sellerUID,
        'userUID': sharedPreferences!.getString('uid'),
        'ItemUID': widget.model!.itemId,
        'itemImage': widget.model!.thumbnailUrl,
        'itemTitle': widget.model!.title,
        'itemShortDescription': widget.model!.shortInfo,
        'totalAmount': ((widget.day! * widget.model!.SingleDayRent!) + (widget.month! * widget.model!.SingleWeekRent!) + (widget.month! * widget.model!.SingleMonthRent!)),
        'status': 'placed',
        'itemType': 'Rent Subscription',
      });
      await FirebaseFirestore.instance.collection('users').doc(sharedPreferences!.getString('uid')).collection('orders').doc(uniqueName).set({
        'OrderID': uniqueName,
        'OrderPlacedAt': DateTime.now(),
        'OrderEnd': DateTime.now().add(Duration(days: totalDays!)),
        'sellerUID': widget.model!.sellerUID,
        'userUID': sharedPreferences!.getString('uid'),
        'ItemUID': widget.model!.itemId,
        'itemImage': widget.model!.thumbnailUrl,
        'itemTitle': widget.model!.title,
        'itemShortDescription': widget.model!.shortInfo,
        'totalAmount': ((widget.day! * widget.model!.SingleDayRent!) + (widget.month! * widget.model!.SingleWeekRent!) + (widget.month! * widget.model!.SingleMonthRent!)),
        'status': 'placed',
        'itemType': 'Rent Subscription',
      });
      await FirebaseFirestore.instance.collection('items').doc(widget.model!.itemId).update({
        'status': 'not available',
      });
      await FirebaseFirestore.instance.collection('sellers').doc(widget.model!.sellerUID).collection('items').doc(widget.model!.itemId!).update({
        'status': 'not available',
      });
      await FirebaseFirestore.instance.collection('sellers').doc(widget.model!.sellerUID).update(
          {
            'totalEarnings': FieldValue.increment(((widget.day! * widget.model!.SingleDayRent!) + (widget.month! * widget.model!.SingleWeekRent!) + (widget.month! * widget.model!.SingleMonthRent!)))
          });
      List itemList = [];
      await FirebaseFirestore.instance.collection('BookTypes').doc('SubscriptionType').get().then((value){
        itemList = value.data()![widget.model!.typeOfSubscription];
      });
      for(var i in itemList){
        if (i['itemID'] == widget.model!.itemId){
          i['status'] = 'not available';
          await FirebaseFirestore.instance.collection('BookTypes').doc('SubscriptionType').update({
            widget.model!.typeOfSubscription!: itemList,
          });
          break;
        }
      }

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay!.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.cyan, Colors.amber])),
        ),
      ),
      body: Column(
        children: [
          Text(
            'Total Price : ₹${(widget.month! * widget.model!.SingleMonthRent!.toInt()) + (widget.week! * widget.model!.SingleWeekRent!.toInt()) + (widget.day! * widget.model!.SingleDayRent!.toInt())}',
            style: GoogleFonts.dancingScript(fontSize: 30),
          ),
          ElevatedButton(
              onPressed: () {
                makePayment('${(widget.month! * widget.model!.SingleMonthRent!.toInt()) + (widget.week! * widget.model!.SingleWeekRent!.toInt()) + (widget.day! * widget.model!.SingleDayRent!.toInt())}');
              },
              child: Text('Pay'))
        ],
      ),
    );
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
}