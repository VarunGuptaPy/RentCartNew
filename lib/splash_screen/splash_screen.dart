import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rent_cart/authentication/auth_screen.dart';
import 'package:rent_cart/globals/globals.dart';
import 'package:rent_cart/main.dart';
import 'package:rent_cart/main_screen/seller/home_screen.dart';
import 'package:rent_cart/main_screen/user/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onMessage.listen((event) {
      RemoteNotification notification = event.notification!;
      AndroidNotification android = event.notification!.android!;
      if(notification != null && android != null){
        flutterLocalNotificationsPlugin.show(notification.hashCode, notification.title, notification.body, NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/ic_launcher',
          )
        ));

      }
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print('A new OnMessageOpenedApp event was published');;
        RemoteNotification notification = event.notification!;
        AndroidNotification android = event.notification!.android!;
        if(notification != null && android != null){
          showDialog(context: context, builder: (_){
            return AlertDialog(
              title: Text(notification.title!),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.body!),

                  ],
                ),
              ),
            );
          });
        }
      });
    });
    Timer(const Duration(seconds: 4), () {
      if (firebaseAuth.currentUser != null) {
        if (sharedPreferences!.getString('role') == 'seller') {
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => SellerHomeScreen()));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => MyHomeScreen()));
        }
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => MyAuthScreen()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('image/splash.png'),
            const Text(
              'Rent Anything Online',
              style: TextStyle(fontFamily: "Signatra", fontSize: 40),
            )
          ],
        ),
      ),
    );
  }
}
