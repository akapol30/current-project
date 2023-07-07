import 'package:flutter/material.dart';

import 'package:project_towin/src/manu/restaurant/res_bundel_card.dart';
import 'package:project_towin/src/manu/restaurant/res_liststore_menu.dart';
import 'package:project_towin/src/manu/restaurant/res_province_north.dart';

import 'package:project_towin/src/modelclass/class_bundel.dart';

class ResLayout extends StatefulWidget {
  const ResLayout({super.key});

  @override
  State<ResLayout> createState() => _ResLayoutState();
}

class _ResLayoutState extends State<ResLayout> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                itemCount: restaurantBundle.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 0.5,
                  childAspectRatio: 1.65,
                ),
                itemBuilder: (context, index) => RestaurantBundleCard(
                    restaurantBundle: restaurantBundle[index],
                    press: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ResListStoreMenu(
                                  categories: ProvinceNorth())));
                      /*if(index==0){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const BookListFoodMenu(categories: CategoriesFood())));
                      }else if(index==1){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const BookListBeverageMenu(categories: CategoriesBeverage())));
                      }else if(index==2){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const BookListDessertMenu(categories: CategoriesDessert())));
                      }else if(index==3){*/
                      //Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (BuildContext context) =>
                      //       const BookListMenu(categories: CategoriesCounty())));
                      //}
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
