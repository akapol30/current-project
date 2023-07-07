import 'package:flutter/material.dart';

import 'package:project_towin/src/manu/travel/TravelSpot.dart';
import 'package:project_towin/src/manu/travel/travel_inplacecard.dart';

class KeyLock extends StatefulWidget {
  const KeyLock({super.key});

  @override
  State<KeyLock> createState() => _KeyLockState();
}

class _KeyLockState extends State<KeyLock> {
  @override
  Widget build(BuildContext context) {
    int count = 0;

    void _onListCountChangeIng(int value) {
      setState(() {
        count = value;
      });
    }

    int dataList = 3;
    List travel = ["คนเดียว", "กับเพื่อน", "กับครอบครัว"];
    List radiotravel = [1, 2, 3];
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("ท่องเที่ยวของฉัน"),
              centerTitle: true,
            ),
            body: Wrap(alignment: WrapAlignment.spaceBetween, children: [
              ...List.generate(
                  1,
                  (index) => InPlaceCard(
                        travelSport: travelSpots[index],
                        isFullCard: true,
                      )),
              Column(
                children: [
                  ...List.generate(dataList, (index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.amber),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: CircleAvatar(),
                              title: Text("L"),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.delete),
                              ),
                            ),
                            Text("My question"),
                            SizedBox(
                              height: 8,
                            ),
                          ]),
                    );
                  })
                ],
              )
            ])));
  }
}
