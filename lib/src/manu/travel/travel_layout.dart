import 'package:flutter/material.dart';

import 'package:project_towin/src/manu/travel/travel_bundel_card.dart';
import 'package:project_towin/src/manu/travel/travel_listtravel_menu.dart';
import 'package:project_towin/src/manu/travel/travel_province_north.dart';

import 'package:project_towin/src/modelclass/class_bundel.dart';

class TravelLayout extends StatefulWidget {
  const TravelLayout({super.key});

  @override
  State<TravelLayout> createState() => _TravelLayoutState();
}

class _TravelLayoutState extends State<TravelLayout> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                itemCount: travelBundle.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 0.5,
                  childAspectRatio: 1.65,
                ),
                itemBuilder: (context, index) => TravelBundleCard(
                    travelBundle: travelBundle[index],
                    press: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const TravelListMenu(
                                  categories: TProvinceNorth())));
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
                      }else if(index==3){
                      //Navigator.of(context).push(MaterialPageRoute(
                       //   builder: (BuildContext context) =>
                       //       const BookListMenu(categories: CategoriesCounty())));
                      }*/
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
