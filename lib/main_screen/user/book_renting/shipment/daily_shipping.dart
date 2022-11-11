// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:number_inc_dec/number_inc_dec.dart';
// import 'package:provider/provider.dart';
// import 'package:rent_cart/Widgets/add_address_screen.dart';
// import 'package:rent_cart/main_screen/user/book_renting/Book_renting_Screen_User.dart';
// import 'package:rent_cart/main_screen/user/book_renting/shipment/book_buying_step2.dart';
// import 'package:rent_cart/providers/daily_price_provider.dart';
//
// import '../../../../models/items.dart';
//
// class DailyShipping extends StatefulWidget {
//   final Items? model;
//
//   DailyShipping({this.model});
//
//   @override
//   State<DailyShipping> createState() => _DailyShippingState();
// }
//
// class _DailyShippingState extends State<DailyShipping> {
//   int? dailyPrice = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController? numberController = TextEditingController();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Number of days',
//           style: TextStyle(
//             fontSize: 40,
//             fontFamily: 'Signatra',
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         NumberInputPrefabbed.roundedButtons(
//           controller: numberController,
//           min: 1,
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Align(
//           child: ElevatedButton(
//             onPressed: () {
//               int.parse(numberController.text) != 0
//                ? Navigator.push(context, MaterialPageRoute(builder: (c) => BookBuying_step2(model: widget.model,totalPrice: widget.model!.SingleDayRent! * int.parse(numberController.text),)))
//                   : Fluttertoast.showToast(msg: 'Please atleast give one number');
//             },
//             child: Text('Proceed'),
//           ),
//           alignment: Alignment.center,
//         )
//       ],
//     );
//   }
// }
