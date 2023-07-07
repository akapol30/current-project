import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_towin/src/BottomPage/page_favorite.dart';
import 'package:project_towin/src/BottomPage/page_info.dart';

import 'package:project_towin/src/manu/book/book_layout.dart';

import 'package:project_towin/src/manu/restaurant/res_layout.dart';

import 'package:project_towin/src/manu/travel/travel_layout.dart';

import 'homepage.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  //const page1({ Key? key }) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  String dropdownValue = 'TH';

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
      /*} else if (index == 2) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => const Wallet()));
    } else if (index == 3) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const Payment()));*/
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

  @override
  Widget build(BuildContext context) {
    //TabController _tabController = TabController(length: 4, vsync: this)
    return DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () {
                  //Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //   builder: (BuildContext context) => MyApp()));
                },
              ),
              /* Align(
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
            title: Text("title_Northern".tr()),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.grey,
              tabs: <Widget>[
                Tab(
                  icon: const Icon(Icons.book),
                  text: "btn_top1".tr(),
                ),
                Tab(
                  icon: const Icon(Icons.restaurant),
                  text: "btn_top2".tr(),
                ),
                Tab(
                  icon: const Icon(Icons.card_travel),
                  text: "btn_top3".tr(),
                ),
                Tab(
                  icon: const Icon(Icons.add_business),
                  text: "btn_top4".tr(),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              const BookLayout(),
              const ResLayout(),
              const TravelLayout(),
              // PromoteStorLayout(),
              Container(
                  color: const Color.fromARGB(100, 100, 100, 100),
                  child: const Center(
                      child: Text("กำลังพัฒนา",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          )))),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: _menuBar,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        ));
  }
}
