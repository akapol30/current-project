import 'package:flutter/material.dart';
import 'package:project_towin/src/manu/book/book_bundel_card.dart';
import 'package:project_towin/src/manu/book/book_categories_beverage.dart';

import 'package:project_towin/src/manu/book/book_categories_dessert.dart';
import 'package:project_towin/src/manu/book/book_categories_food.dart';

import 'package:project_towin/src/manu/book/book_listbeverage_menu.dart';
import 'package:project_towin/src/manu/book/book_listdessert_menu.dart';
import 'package:project_towin/src/manu/book/book_listfood_menu.dart';

import 'package:project_towin/src/modelclass/class_bundel.dart';

class BookLayout extends StatefulWidget {
  const BookLayout({super.key});

  @override
  State<BookLayout> createState() => _BookLayoutState();
}

class _BookLayoutState extends State<BookLayout> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                itemCount: recipeBundles.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 0.5,
                  childAspectRatio: 1.65,
                ),
                itemBuilder: (context, index) => RecipeBundelCard(
                    recipeBundle: recipeBundles[index],
                    press: () {
                      if (index == 0) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const BookListFoodMenu(
                                    categories: CategoriesFood())));
                      } else if (index == 1) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const BookListBeverageMenu(
                                    categories: CategoriesBeverage())));
                      } else if (index == 2) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const BookListDessertMenu(
                                    categories: CategoriesDessert())));
                      }
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
