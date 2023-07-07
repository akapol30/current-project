import 'package:flutter/material.dart';
import 'package:project_towin/src/manu/book/book_detail.dart';
import 'package:project_towin/src/modelclass/class_list_food.dart';

class SubPageFavBook extends StatefulWidget {
  const SubPageFavBook({super.key});

  @override
  State<SubPageFavBook> createState() => _SubPageFavBookState();
}

class _SubPageFavBookState extends State<SubPageFavBook> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Food.getDatafavorite(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: Food.foodListfav.length,
              itemBuilder: (context, index) {
                final food = Food.foodListfav[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SlidingUpPanelExampleBook(
                                  recipe: Food.foodListfav[index]);
                            },
                          ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(bottom: 13),
                            decoration: BoxDecoration(
                              color: const Color(0xffFBCEDC),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Center(child: Image.network(food.pic![0])),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    food.foodname!,
                                    style: const TextStyle(
                                        fontFamily: 'Mitr',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                  "#${food.foodtype}",
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontFamily: 'Mitr',
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  "Rating : ${food.rating}",
                                  style: const TextStyle(
                                    fontFamily: 'Mitr',
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        });
  }
}
