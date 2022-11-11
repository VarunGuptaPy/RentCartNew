import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rent_cart/Widgets/user_Item_Card_Book.dart';

import '../../../Widgets/item_card.dart';
import '../../../models/items.dart';

class ItemScreen extends StatefulWidget {
  String? type = "";
  ItemScreen({this.type});
  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.amber, Colors.cyan]))),
          title: Text(
            widget.type!,
            style: TextStyle(
              fontFamily: 'Signatra',
              fontSize: 30,
            ),
          ),
          centerTitle: true,
        ),
        body: Visibility(
          visible: true,
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Divider(height: 4),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('items')
                      .where('type', isEqualTo: 'Book Renting')
                      .where('itemType', isEqualTo: '${widget.type}')
                      .orderBy('timesRented', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return snapshot.hasData == false
                        ? SliverToBoxAdapter(child: Text('No Items'))
                        : SliverStaggeredGrid.countBuilder(
                            crossAxisCount: 1,
                            staggeredTileBuilder: (c) =>
                                const StaggeredTile.fit(1),
                            itemBuilder: (context, index) {
                              Items model = Items.fromJson(
                                  snapshot.data!.docs[index].data()!
                                      as Map<String, dynamic>);
                              return UserItemCardBook(
                                model: model,
                                context: context,
                              );
                            },
                            itemCount: snapshot.data!.docs.length);
                  },
                ),
                SliverToBoxAdapter(
                  child: Divider(height: 4),
                ),
              ],
            ),
          ),
        ));
  }
}
