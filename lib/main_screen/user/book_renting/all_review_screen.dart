import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../Widgets/review_widget.dart';
import '../../../models/items.dart';
import '../../../models/reviews.dart';

class AllReviewScreen extends StatefulWidget {
  final Items? model;
  AllReviewScreen({this.model});

  @override
  State<AllReviewScreen> createState() => _AllReviewScreenState();
}

class _AllReviewScreenState extends State<AllReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('items')
                  .doc(widget.model!.itemID)
                  .collection('reviews')
                  .get(),
              builder: (context, snapshot) {
                return snapshot.hasData == false
                    ? SliverToBoxAdapter(child: Text('No Items'))
                    : SliverStaggeredGrid.countBuilder(
                        crossAxisCount: 1,
                        staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                        itemBuilder: (context, index) {
                          Reviews model = Reviews.fromJson(
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>);

                          return ReviewWidget(
                            userName: model.reviewUserName.toString(),
                            userAvatarUrl: model.reviewUserImage.toString(),
                            review: model.review,
                            model: widget.model,
                            whoAreU: 'all review',
                          );
                        },
                        itemCount: snapshot.data!.docs.length);
              },
            )
          ],
        ),
      ),
    );
  }
}
