import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:project_towin/src/BottomPage/page_favorite.dart';
import 'package:project_towin/src/BottomPage/page_info.dart';
import 'package:project_towin/src/BottomPage/page_payment.dart';
import 'package:project_towin/src/BottomPage/page_wallet.dart';
import 'package:project_towin/src/manu/book/book_alllist_popular.dart';

import 'package:project_towin/src/manu/travel/travel_addmenu_north.dart';
import 'package:project_towin/src/manu/travel/travel_detail.dart';

import 'package:project_towin/src/modelclass/class_list_food.dart';
import 'package:banner_carousel/banner_carousel.dart';

import 'package:project_towin/src/page/homepage.dart';

class TravelListMenu extends StatefulWidget {
  final Widget categories;
  const TravelListMenu({Key? key, required this.categories}) : super(key: key);

  @override
  State<TravelListMenu> createState() => _TravelListMenuState();
}

class _TravelListMenuState extends State<TravelListMenu> {
  static List<BannerModel> listBanners = [];
  void getImage(Food food) {
    if (food.pic!.length != listBanners.length) {
      int count = food.pic!.length;
      for (int i = 0; i <= count - 1; i++) {
        listBanners.add(BannerModel(imagePath: food.pic![i], id: i.toString()));
      }
    }
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => const Home()));
    } else if (index == 1) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const Favorite()));
    } else if (index == 2) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => const Wallet()));
    } else if (index == 3) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const Payment()));
    } else if (index == 4) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => const Info()));
    }
  }

  final List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: const Icon(Icons.home),
      label: 'btn_bottom1'.tr(),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.favorite),
      label: 'btn_bottom2'.tr(),
    ),
    BottomNavigationBarItem(
        icon: const Icon(Icons.account_balance_wallet),
        label: 'btn_bottom3'.tr()),
    BottomNavigationBarItem(
      icon: const Icon(Icons.payment),
      label: 'btn_bottom4'.tr(),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.info),
      label: 'btn_bottom5'.tr(),
    ),
  ];

  Widget dataFoodPopular() {
    return FutureBuilder(
        future: Food.call(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: const EdgeInsets.only(left: 15),
            margin: const EdgeInsets.only(bottom: 10),
            height: 315,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Food.foodList.length,
              itemBuilder: (context, index) {
                final food = Food.foodList[index];
                getImage(food);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SlidingUpPanelExampleTravel(
                              recipe: Food.foodList[index]);
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 15, left: 0),
                    width: 300,
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: const Color(0xffFBCEDC),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: BannerCarousel(
                                banners: listBanners,
                                customizedIndicators:
                                    const IndicatorModel.animation(
                                        width: 20,
                                        height: 10,
                                        spaceBetween: 2,
                                        widthAnimation: 20),
                                height: 150,
                                activeColor: Colors.amberAccent,
                                disableColor: Colors.white,
                                animation: true,
                                borderRadius: 10,
                                width: double.infinity,
                                indicatorBottom: false,
                                onTap: (val) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SlidingUpPanelExampleTravel(
                                            recipe: Food.foodList[index]);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
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
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.purple.shade300,
                                        borderRadius: BorderRadius.circular(
                                          16, // 16
                                        )),
                                    child: Text(
                                      "#${food.foodtype!}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Mitr',
                                        fontSize: 12,
                                      ),
                                    )),
                                const SizedBox(
                                  height: 5,
                                ),
                                RatingBar.builder(
                                  initialRating: 4,
                                  minRating: 1,
                                  itemSize: 20,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  updateOnDrag: true,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.red,
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                                Text("Rating : ${5.toStringAsFixed(2)} / 5.00"),
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
          );
        });
  }

  Widget dataFoodListAll() {
    return FutureBuilder(
        future: Food.call(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: ListView.builder(
              shrinkWrap: true,
              reverse: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: Food.foodList.length,
              itemBuilder: (context, index) {
                final food = Food.foodList[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SlidingUpPanelExampleTravel(
                                  recipe: Food.foodList[index]);
                            },
                          ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 100,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(bottom: 13),
                            decoration: BoxDecoration(
                              color: const Color(0xffFBCEDC),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: FadeInImage(
                              image: NetworkImage(
                                food.pic![0],
                              ),
                              fit: BoxFit.cover,
                              placeholder:
                                  const AssetImage('assets/images/loading.gif'),
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
                                  width: 100,
                                  child: Text(
                                    food.foodname!,
                                    style: const TextStyle(
                                        fontFamily: 'Mitr',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.purple.shade300,
                                      borderRadius: BorderRadius.circular(
                                        16, // 16
                                      )),
                                  child: Text(
                                    "#${food.foodtype!}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Mitr',
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  itemSize: 20,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  updateOnDrag: true,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.red,
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                                Text("Rating : ${5.toStringAsFixed(2)} / 5.00"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const FavB(),
                  ],
                );
              },
            ),
          );
        });
  }

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
          /*Align(
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
              )),*/
        ],
        title: const Text("ท่องเที่ยวภาคเหนือ",
            style: TextStyle(fontFamily: 'Mitr')),
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
                        }),
                  ],
                ),
              ),
              dataFoodPopular(),
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
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const AddTravelNorth()));
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.add, color: Color(0xffFF5F99)),
                          Text(
                            "Add",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Mitr',
                              color: Color(0xffFF5F99),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              dataFoodListAll(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _menuBar,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
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
