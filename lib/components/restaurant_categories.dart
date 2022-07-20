import 'package:flutter/material.dart';

import 'categories.dart';

class RestaurantCategories extends SliverPersistentHeaderDelegate {
  final ValueChanged<int> onChanged;
  final int selectedIndex;

  RestaurantCategories({required this.onChanged, required this.selectedIndex});

  ///
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 52,
      color: Colors.white,
      child: Categories(
        onChanged: onChanged,
        selectedIndex: selectedIndex,
      ),
    );
  }

  //-----------

  @override
  double get maxExtent {
    return 52;
  }

  @override
  double get minExtent {
    return 52;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
