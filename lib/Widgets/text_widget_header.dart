import 'package:flutter/material.dart';

class textWidgetHeader extends SliverPersistentHeaderDelegate {
  String? title;
  textWidgetHeader({this.title});
  @override
  Widget build(
      BuildContext context, double crossAxisOffset, bool overlapsContent) {
    return InkWell(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyan, Colors.amber],
          ),
        ),
        height: 80.0,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: InkWell(
          child: Text(
            title!,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 30,
              fontFamily: "Signatra",
              letterSpacing: 2,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 50;

  @override
  // TODO: implement minExtent
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
