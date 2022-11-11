import 'package:flutter/material.dart';
import 'package:rent_cart/main_screen/user/book_renting/all_review_screen.dart';

import '../models/items.dart';

class ReviewWidget extends StatefulWidget {
  final String? userName;
  final String? userAvatarUrl;
  final String? review;
  final Items? model;
  final String? whoAreU;

  ReviewWidget({
    this.userName,
    this.userAvatarUrl,
    this.review,
    this.model,
    this.whoAreU,
  });

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Material(
              borderRadius: const BorderRadius.all(Radius.circular(80)),
              elevation: 10,
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.userAvatarUrl!,
                  ),
                ),
              ),
            ),
            Text(widget.userName!),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          widget.review.toString(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
