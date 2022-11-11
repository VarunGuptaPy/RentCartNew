import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:what3words/what3words.dart';

SharedPreferences? sharedPreferences;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
String appName = "RentCart";
var api = What3WordsV3('MWJ1LVOW');

// razor pay api call tut - https://www.youtube.com/watch?v=pakLL37M6KI