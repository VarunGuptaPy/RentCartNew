import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_cart/splash_screen/splash_screen.dart';

import '../../globals/globals.dart';

class TotalEarnings extends StatefulWidget {
  const TotalEarnings({Key? key}) : super(key: key);

  @override
  State<TotalEarnings> createState() => _TotalEarningsState();
}

class _TotalEarningsState extends State<TotalEarnings> {
  double OldSellerEarnings = 0;
  GetSellerEarning() {
    FirebaseFirestore.instance
        .collection('sellers')
        .doc(sharedPreferences!.getString('uid'))
        .get()
        .then((snapshot) {
      setState(() {
        OldSellerEarnings =
            double.parse(snapshot.data()!['earnings'].toString());
      });
    });
  }

  @override
  void initState() {
    super.initState();
    GetSellerEarning();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "₹ $OldSellerEarnings",
              style: const TextStyle(
                  fontFamily: "Signatra", fontSize: 80, color: Colors.white),
            ),
            const Text(
              "Total Amount",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 200,
              height: 40,
              child: Divider(
                color: Colors.white,
                thickness: 4,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => SplashScreen()));
              },
              child: Card(
                color: Colors.white54,
                child: ListTile(
                  leading: Icon(
                    Icons.back_hand,
                    color: Colors.white,
                  ),
                  title: Text(
                    'back',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
