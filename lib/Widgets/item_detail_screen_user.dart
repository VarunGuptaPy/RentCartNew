import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rent_cart/Widgets/review_widget.dart';
import 'package:rent_cart/globals/globals.dart';
import 'package:rent_cart/main_screen/user/book_renting/all_review_screen.dart';
import 'package:rent_cart/main_screen/user/book_renting/shipment/book_buying_step1.dart';
import 'package:rent_cart/main_screen/user/book_renting/write_review_screen.dart';
import 'package:rent_cart/models/items.dart';
import 'package:rent_cart/models/reviews.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'item_detail_screen_field.dart';

class ItemDetailScreenUser extends StatefulWidget {
  final Items? model;

  ItemDetailScreenUser({this.model});

  @override
  State<ItemDetailScreenUser> createState() => _ItemDetailScreenUserState();
}

class _ItemDetailScreenUserState extends State<ItemDetailScreenUser> {
  @override
  Widget build(BuildContext context) {
    bool? WriteAReview = false;

    final items = [
      widget.model!.thumbnailUrl.toString(),
      widget.model!.thumbnailUrl2.toString(),
      widget.model!.thumbnailUrl3.toString(),
    ];
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.amber, Colors.cyan],
            ),
          ),
        ),
        title: Text(
          widget.model!.title.toString(),
          style: TextStyle(
            fontFamily: 'Signatra',
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: [
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
              Text(
                widget.model!.title!.toString(),
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: "Signatra",
                ),
              ),
              Text(
                widget.model!.LongDescription!,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 20),
              ),
              ItemDetailScreenField('rent per day:',
                  "₹" + widget.model!.SingleDayRent.toString()),
              ItemDetailScreenField('rent per week:',
                  "₹" + widget.model!.SingleWeekRent.toString()),
              ItemDetailScreenField('rent per month:',
                  "₹" + widget.model!.SingleMonthRent.toString()),
              ItemDetailScreenField('real price of book:',
                  "₹" + widget.model!.FullPrice.toString()),
              ItemDetailScreenField(
                  'Book Type:', widget.model!.itemType.toString()),
              ItemDetailScreenField(
                  'seller Name:', widget.model!.sellerName.toString()),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => BookBuyingStep1(
                                model: widget.model,
                              )));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.amber, Colors.cyan],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Place Order",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Reviews ()',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('items')
                    .doc(widget.model!.itemID)
                    .collection('reviews')
                    .limit(3)
                    .snapshots(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Reviews model = Reviews.fromJson(
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>);
                            return ReviewWidget(
                              userName: model.reviewUserName,
                              userAvatarUrl: model.reviewUserImage,
                              review: model.review,
                              model: widget.model,
                              whoAreU: '',
                            );
                          },
                          itemCount: snapshot.data!.docs.length,
                        )
                      : Container();
                },
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => AllReviewScreen(
                                  model: widget.model!,
                                )));
                  },
                  child: Text(
                    'See All reviews',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )),
              WriteReviewWidget(
                model: widget.model,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
