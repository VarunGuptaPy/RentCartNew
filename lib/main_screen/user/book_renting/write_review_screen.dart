import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rent_cart/globals/globals.dart';
import 'package:rent_cart/splash_screen/splash_screen.dart';

import '../../../models/items.dart';

class WriteReviewWidget extends StatefulWidget {
  final Items? model;
  WriteReviewWidget({this.model});

  @override
  State<WriteReviewWidget> createState() => _WriteReviewWidgetState();
}

class _WriteReviewWidgetState extends State<WriteReviewWidget> {
  TextEditingController? reviewController = TextEditingController();
  String? text = "";
  String? uniqueName = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            setState(() {
              text = value;
            });
          },
          decoration: InputDecoration(hintText: "Write review here"),
        ),
        ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('items')
                  .doc(widget.model!.itemID)
                  .collection('reviews')
                  .doc(uniqueName)
                  .set({
                'review': text,
                'reviewUser': sharedPreferences!.getString('uid'),
                'reviewUserName': sharedPreferences!.getString('name'),
                'reviewUserImage': sharedPreferences!.getString('photoUrl'),
              });
              FirebaseFirestore.instance
                  .collection('sellers')
                  .doc(widget.model!.sellerUID)
                  .collection('items')
                  .doc(widget.model!.itemID)
                  .collection('reviews')
                  .doc(uniqueName)
                  .set({
                'review': text,
                'reviewUser': sharedPreferences!.getString('uid'),
                'reviewUserName': sharedPreferences!.getString('name'),
                'reviewUserImage': sharedPreferences!.getString('photoUrl'),
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => SplashScreen()));
            },
            child: Text('Post Review')),
      ],
    );
  }
}
