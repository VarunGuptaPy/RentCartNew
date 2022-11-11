import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_cart/Widgets/subscription_home_row.dart';
import 'package:rent_cart/main_screen/user/book_renting/item_screen.dart';

import '../../../globals/globals.dart';

class BookRentingScreenUser extends StatefulWidget {
  const BookRentingScreenUser({Key? key}) : super(key: key);

  @override
  State<BookRentingScreenUser> createState() => _BookRentingScreenUserState();
}

class _BookRentingScreenUserState extends State<BookRentingScreenUser> {
  List<dynamic> BookTypes = [];
  List<dynamic> Action = [];
  List<dynamic> musical = [];
  List<dynamic> sports = [];
  List<dynamic> computer = [];
  List<dynamic> math = [];
  List<dynamic> science = [];
  List<dynamic> language = [];
  List<dynamic> fiction = [];
  List<dynamic> non_fiction = [];
  List<dynamic> story = [];
  List<dynamic> other = [];
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('BookTypes')
        .doc('BookType')
        .get()
        .then((value) {
      setState(() {
        BookTypes = value.data()!['types'];
        Action = value.data()!['Action'];
        musical = value.data()!['musical'];
        sports = value.data()!['sports'];
        computer = value.data()!['computer'];
        math = value.data()!['math'];
        science = value.data()!['science'];
        language = value.data()!['language'];
        fiction = value.data()!['fiction'];
        non_fiction = value.data()!['non fiction'];
        story = value.data()!['story'];
        other = value.data()!['other'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: BookTypes.length,
      itemBuilder: (context, index){
        var value = BookTypes[index];
        if (value == 'Action'){
          return SubscriptionHomeRow(value: 'Action',ItemList: Action,type: "BookRenting",typeOfRent: 'Rent Book',);
        }
        // else if (value == 'comedy'){
        //   return SubscriptionHomeRow(value: 'comedy',ItemList: comedy,type: 'BookRenting',typeOfRent: 'Rent Book',);
        // }
        else if (value == 'musical'){
          return SubscriptionHomeRow(value: 'musical',ItemList: musical,type: 'BookRenting',typeOfRent: 'Rent Book',);
        }
        else if (value == 'sports'){
          return SubscriptionHomeRow(value: 'sports',ItemList: sports,type: 'BookRenting',typeOfRent: 'Rent Book',);
        }
        else if (value == 'computer'){
          return SubscriptionHomeRow(value: 'computer',ItemList: computer,type: 'BookRenting',typeOfRent: 'Rent Book',);
        }
        else if (value == 'math'){
          return SubscriptionHomeRow(value: 'math',ItemList: math,type: 'BookRenting',typeOfRent: 'Rent Book',);
        }
        else if (value == 'language'){
          return SubscriptionHomeRow(value: 'language',ItemList: language,type: 'BookRenting',typeOfRent: 'Rent Book',);
        }
        else if (value == 'fiction'){
          return SubscriptionHomeRow(value: 'fiction',ItemList: fiction,type: 'BookRenting',typeOfRent: 'Rent Book',);
        }
        else if (value == 'non fiction'){
          return SubscriptionHomeRow(value: 'non fiction',ItemList: non_fiction,type: 'BookRenting',typeOfRent: 'Rent Book',);
        }
        else if (value == 'story'){
          return SubscriptionHomeRow(value: 'story',ItemList: story,type: 'BookRenting',typeOfRent: 'Rent Book',);
        }
        else if (value == 'other'){
          return SubscriptionHomeRow(value: 'other',ItemList: other,type: 'BookRenting',typeOfRent: 'Rent Book',);
        }
        else {
          return Container();
        }
      },
    );
  }
}
