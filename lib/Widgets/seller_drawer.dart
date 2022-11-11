import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rent_cart/authentication/auth_screen.dart';
import 'package:rent_cart/authentication/seller/sellerAuth.dart';
import 'package:rent_cart/main_screen/seller/Orders/seller_order_screen.dart';
import 'package:rent_cart/main_screen/seller/total_earnings_screen.dart';
import 'package:http/http.dart' as http;
import '../globals/globals.dart';

class SellerDrawer extends StatelessWidget {
  const SellerDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 25),
            child: Column(
              children: [
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: SizedBox(
                    height: 160,
                    width: 160,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          sharedPreferences!.getString("photoUrl")!),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  sharedPreferences!.getString("name")!,
                  style: const TextStyle(
                      color: Colors.black, fontFamily: "Train", fontSize: 20),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(1.0),
            child: Column(
              children: [
                const Divider(
                  height: 10,
                  thickness: 2,
                  color: Colors.grey,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {},
                ),
                const Divider(
                  height: 10,
                  thickness: 2,
                  color: Colors.grey,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.monetization_on,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "My Earnings",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => TotalEarnings()));
                  },
                ),
                const Divider(
                  height: 10,
                  thickness: 2,
                  color: Colors.grey,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.reorder,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "New Orders",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c) => SellerOrderScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  thickness: 2,
                  color: Colors.grey,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.local_shipping,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "History - Orders",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {},
                ),
                const Divider(
                  height: 10,
                  thickness: 2,
                  color: Colors.grey,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    firebaseAuth.signOut().then(
                          (value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => const MyAuthScreen()),
                          ),
                        );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Send Notification",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),headers: {
                      "Content-Type": "application/json",
                      "Authorization": "key=AAAAWUXN9cY:APA91bEz47QIUAoiizUtFTrBAabw-kqyvD2Z13GnjVet0HtPbJ2pFy9Z_hW6yptbWepJ_cydPNZvtR_xE42mTrMjbuUcQY3QlXn2ke5c-KqgUOx7QdjD6Lrp97m-vUKpRriVVwsjMvjF",
                    },body: jsonEncode({
                      "priority": "high",
                      "data": {
                        "click_action": "FLUTTER_NOTIFICATION_CLICK",
                        "status": "done",
                        "body": "please change your password to" +
                            " the password give inside notification of app",
                        "title": "Subscritpion Expired",
                      },
                      "notification": {
                        "title": "Subscritpion Expired",
                        "body": "please change your password to"+
                            " the password give inside notification of app",
                        "android_channel_id": "RentCart",
                      },
                      "to": 'e5WJdAKeQ9iDBurJ1v4-df:APA91bHPNqbNnLhXJp7Jdxxf90i7WnPQz-eT0bUqP_JQ0XYeTiEV1NL9L6thnXh04nzuSsWZjvuwp_R-zares2UaGLhTkb1n3odvDKKrSgvWSjXG8J_L5sHEfD2KUMSkgwvi_Qa7gZD5',
                    }));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
