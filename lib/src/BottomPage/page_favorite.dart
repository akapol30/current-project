import 'package:flutter/material.dart';

import 'package:project_towin/src/BottomPage/page_subfavorite_book.dart';

import 'package:project_towin/src/BottomPage/page_subfavorite_res.dart';
import 'package:project_towin/src/BottomPage/page_subfavorite_travel.dart';

import 'package:easy_localization/easy_localization.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
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
                //Navigator.of(context).push(MaterialPageRoute(
                //   builder: (BuildContext context) => MyApp()));
              },
            )
          ],
          title: const Text("ชื่นชอบ", style: TextStyle(fontFamily: 'Mitr')),
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
            const SubPageFavBook(),
            const SubPageFavRes(),
            const SubPageFavTravel(),
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
      ),
    );
  }
}
