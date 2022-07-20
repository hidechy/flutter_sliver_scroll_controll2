import 'package:flutter/material.dart';

import 'components/menu_card.dart';
import 'components/menu_category_item.dart';

import 'models/menu.dart';

import 'components/restaurant_categories.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  final scrollController = ScrollController();

  double restaurantInfoHeader = 200 + 170 + kToolbarHeight;

  int selectedCategoryIndex = 0;

  List<double> breakPoints = [];

  ///
  @override
  void initState() {
    super.initState();

    createBreakPoints();

    scrollController.addListener(() {
      updateCategoryIndexOnScroll(scrollController.offset);
    });
  }

  ///
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  ///
  void scrollToCategory(int index) {
    if (selectedCategoryIndex != index) {
      int totalItems = 0;

      for (var i = 0; i < index; i++) {
        totalItems += demoCategoryMenus[i].items.length;
      }

      scrollController.animateTo(
        restaurantInfoHeader -
            adjustHeight(index) -
            52 +
            ((100 + 16) * totalItems),
        duration: const Duration(microseconds: 500),
        curve: Curves.ease,
      );
    }

    setState(() {
      selectedCategoryIndex = index;
    });
  }

  ///
  int adjustHeight(int index) {
    return (index == 0) ? 50 : (-50 * (index - 1));
  }

  ///
  void createBreakPoints() {
    double firstBreakPoint =
        restaurantInfoHeader + (demoCategoryMenus[0].items.length * (100 + 16));
    breakPoints.add(firstBreakPoint);

    for (var i = 1; i < demoCategoryMenus.length; i++) {
      double breakPoint =
          breakPoints.last + (demoCategoryMenus[i].items.length * (100 + 16));
      breakPoints.add(breakPoint);
    }
  }

  ///
  void updateCategoryIndexOnScroll(double offset) {
    for (var i = 0; i < demoCategoryMenus.length; i++) {
      if (i == 0) {
        if ((offset < breakPoints.first) && (selectedCategoryIndex != 0)) {
          setState(() {
            selectedCategoryIndex = 0;
          });
        }
      } else if ((breakPoints[i - 1] <= offset) && (offset < breakPoints[i])) {
        if (selectedCategoryIndex != i) {
          setState(() {
            selectedCategoryIndex = i;
          });
        }
      }
    }
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          ///

          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/Header-image.png',
                fit: BoxFit.cover,
              ),
            ),
            leading: const CircleAvatar(
              backgroundColor: Colors.black,
            ),
          ),

          ///

          SliverToBoxAdapter(
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(0.3),
              ),
              child: Container(),
            ),
          ),

          ///

          //---------------------------------------

          SliverPersistentHeader(
            delegate: RestaurantCategories(
              onChanged: scrollToCategory,
              selectedIndex: selectedCategoryIndex,
            ),
            pinned: true,
          ),

          //---

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return MenuCategoryItem(
                    title: demoCategoryMenus[index].category,
                    items: demoCategoryMenus[index].items.map((val) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: MenuCard(image: val.image),
                      );
                    }).toList(),
                  );
                },
                childCount: demoCategoryMenus.length,
              ),
            ),
          ),

          //---------------------------------------
        ],
      ),
    );
  }
}
