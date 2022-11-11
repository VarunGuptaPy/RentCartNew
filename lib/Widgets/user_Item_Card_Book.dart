import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_cart/Widgets/item_detail_screen_user.dart';
import 'package:rent_cart/globals/globals.dart';
import 'package:rent_cart/main_screen/seller/rent_book/item_detail_screen.dart';

import '../models/items.dart';

class UserItemCardBook extends StatefulWidget {
  final Items? model;
  final BuildContext? context;

  UserItemCardBook({this.model, this.context});

  @override
  _UserItemCardBookState createState() => _UserItemCardBookState();
}

class _UserItemCardBookState extends State<UserItemCardBook> {
  @override
  Widget build(BuildContext context) {
    final items = [
      widget.model!.thumbnailUrl.toString(),
      widget.model!.thumbnailUrl2.toString(),
      widget.model!.thumbnailUrl3.toString(),
    ];
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => ItemDetailScreenUser(
              model: widget.model,
            ),
          ),
        );
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Container(
          height: 280,
          width: 60,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * .3,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: items.map((index) {
                      return Builder(builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 1.0),
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Image.network(
                              index,
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      });
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(
                height: 4.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.model!.title!.length >= 25
                        ? '${widget.model!.title.toString().substring(0, 10)}...'
                        : widget.model!.title!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: "Train",
                      color: Colors.cyan,
                    ),
                  ),
                  Text("₹" + widget.model!.SingleDayRent.toString() + '/Day'),
                ],
              ),
              // IconButton(
              //   icon: Icon(
              //     Icons.delete,
              //     color: Colors.pinkAccent,
              //   ),
              //   onPressed: () async {
              //     await FirebaseFirestore.instance
              //         .collection('sellers')
              //         .doc(sharedPreferences!.getString('uid'))
              //         .collection('items')
              //         .doc(widget.model!.itemID)
              //         .delete();
              //     await FirebaseFirestore.instance
              //         .collection('items')
              //         .doc(widget.model!.itemID)
              //         .delete();
              //   },
              // ),
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
