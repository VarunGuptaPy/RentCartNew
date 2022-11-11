// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:number_inc_dec/number_inc_dec.dart';
//
// import '../../../../models/items.dart';
// import 'book_buying_step2.dart';
//
// class MonthlyShipping extends StatefulWidget {
//   final Items? model;
//
//   MonthlyShipping({this.model});
//
//   @override
//   State<MonthlyShipping> createState() => _MonthlyShippingState();
// }
//
// class _MonthlyShippingState extends State<MonthlyShipping> {
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController? monthController = TextEditingController();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Number of Month',
//           style: TextStyle(
//             fontSize: 40,
//             fontFamily: 'Signatra',
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         NumberInputPrefabbed.roundedButtons(
//           controller: monthController,
//           min: 1,
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         ElevatedButton(
//             onPressed: () {
//               int.parse(monthController.text) != 0
//                ? Navigator.push(context, MaterialPageRoute(builder: (c) => BookBuying_step2(model: widget.model,totalPrice: widget.model!.SingleMonthRent! * int.parse(monthController.text),)))
//                   : Fluttertoast.showToast(msg: 'please give atleast one number');
//             },
//             child: Text('Proceed'))
//       ],
//     );
//   }
// }
