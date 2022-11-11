import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:rent_cart/providers/daily_price_provider.dart';
import 'package:rent_cart/splash_screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'globals/globals.dart';
const AndroidNotificationChannel channel = AndroidNotificationChannel('high_importance_channel', 'High Importance Notification',description: 'This channel is used for important notifications.',importance: Importance.high,playSound: true,);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up : ${message.messageId}');
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51K1qZsSImF7xw0PtM9BkKaJPfXcWfNkqTkEfGnusMEOonOYtMreSwCzXU0fLzdWkkTSUIsf6Dvz2lhEuyhfj7vsq00fIcpQXy2';
  FirebaseApp app = await Firebase.initializeApp();
  sharedPreferences = await SharedPreferences.getInstance();
  FirebaseMessaging.onBackgroundMessage((message) => _firebaseMessagingBackgroundHandler(message));
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    sound: true,
    badge: true,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DailyPriceProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'rent cart',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
