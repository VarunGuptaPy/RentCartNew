// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:number_inc_dec/number_inc_dec.dart';
//
// import '../../../../models/items.dart';
// import 'book_buying_step2.dart';
//
// class WeeklyShipping extends StatefulWidget {
//   final Items? model;
//
//   WeeklyShipping({this.model});
//
//   @override
//   State<WeeklyShipping> createState() => _WeeklyShippingState();
// }
//
// class _WeeklyShippingState extends State<WeeklyShipping> {
//   TextEditingController? weekController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Number of Week',
//           style: TextStyle(fontSize: 40, fontFamily: 'Signatra'),),
//         SizedBox(
//           height: 20,
//         ),
//         NumberInputPrefabbed.roundedButtons(
//           controller: weekController!,
//           min: 1,
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Align(
//           alignment: Alignment.center,
//           child: ElevatedButton(
//             onPressed: () {
//               int.parse(weekController!.text) != 0
//                   ? Navigator.push(context, MaterialPageRoute(builder: (c) => BookBuying_step2(model: widget.model,totalPrice: widget.model!.SingleWeekRent! * int.parse(weekController!.text),)))
//               : Fluttertoast.showToast(msg: 'Please atleast give one number');
//             },
//             child: Text('Proceed'),
//           ),
//         )
//       ],
//     );
//   }
// }
