import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:project_towin/src/manu/book/book_alllist_popular.dart';

import 'package:project_towin/src/modelclass/class_list_food.dart';

class BookListBeverageMenu extends StatefulWidget {
  final Widget categories;
  const BookListBeverageMenu({Key? key, required this.categories})
      : super(key: key);

  @override
  State<BookListBeverageMenu> createState() => _BookListBeverageMenuState();
}

class _BookListBeverageMenuState extends State<BookListBeverageMenu> {
  String dropdownValue = 'TH';
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              //Navigator.of(context).pushReplacement(MaterialPageRoute(
              //   builder: (BuildContext context) => MyApp()));
            },
          ),
          Align(
              alignment: Alignment.center,
              child: DropdownButton<String>(
                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['TH', 'EN', 'CN', 'TW']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
        ],
        title:
            const Text("อาหารภาคเหนือ", style: TextStyle(fontFamily: 'Mitr')),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Center(
                        child: CircleAvatar(
                          radius: 72,
                          backgroundImage: NetworkImage(user.photoURL!),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(user.displayName!,
                        style:
                            const TextStyle(fontSize: 16, fontFamily: 'Mitr')),
                  ],
                ),
              ),
              widget.categories,
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Popular",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Mitr',
                      ),
                    ),
                    IconButton(
                        icon: Image.asset(
                          "assets/images/filter.png",
                          width: 22,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const BookAllListPopular()));
                        })
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15),
                margin: const EdgeInsets.only(bottom: 10),
                height: 315,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Food.foodList.length,
                  itemBuilder: (context, index) {
                    final food = Food.foodList[index];
                    return GestureDetector(
                      onTap: () {
                        /* Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailFood(food: food);
                            },
                          ),
                        );*/
                      },
                      child: Container(
                        padding: const EdgeInsets.only(right: 15, left: 0),
                        width: 225,
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: const Color(0xffFBCEDC),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /*Image.asset(
                                  beverage.image,
                                  width: 150,
                                  height: 130,
                                ),*/
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      food.foodname!,
                                      style: const TextStyle(
                                        fontFamily: 'Mitr',
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      food.flav!,
                                      style: const TextStyle(
                                        fontFamily: 'Mitr',
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "\$",
                                      style: const TextStyle(
                                        fontFamily: 'Mitr',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "New in",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Mitr',
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "See all",
                        style: TextStyle(
                          color: Color(0xffFF5F99),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: Food.foodList.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                              child: Center(),
                              // child: Image.asset(Food.foodList[index].pic[0])),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            SizedBox(
                              height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    child: Text(
                                      Food.foodList[index].foodname!,
                                      style: const TextStyle(
                                        fontFamily: 'Mitr',
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "\$",
                                    style: const TextStyle(
                                      fontFamily: 'Mitr',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const FavB(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavB extends StatefulWidget {
  const FavB({Key? key}) : super(key: key);

  @override
  State<FavB> createState() => _FavBState();
}

class _FavBState extends State<FavB> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          isFav = !isFav;
        });
      },
      icon: Icon(
        isFav ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
        color: const Color(0xffFF5F99),
        size: 24.0,
      ),
    );
  }
}
