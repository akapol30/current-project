import 'package:flutter/material.dart';

class SubPageFavTravel extends StatefulWidget {
  const SubPageFavTravel({super.key});

  @override
  State<SubPageFavTravel> createState() => _SubPageFavTravelState();
}

class _SubPageFavTravelState extends State<SubPageFavTravel> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return SizedBox(
              height: 125,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      height: 110,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.pink.shade200,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0), //(x,y)
                                    blurRadius: 3.0,
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.only(left: 3),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 120.0,
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/MaeKlangLuangHouse1.jpg'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: const [
                                                Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 10, 0, 0),
                                                    child: Text(
                                                        "บ้านแม่กลางหลวง",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ))),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                mainAxisSize: MainAxisSize.min,
                                                children: const [
                                                  Icon(Icons.gps_fixed),
                                                  SizedBox(width: 5),
                                                  Text("เชียงใหม่"),
                                                  Align(
                                                      alignment:
                                                          Alignment.center),
                                                  SizedBox(width: 5),
                                                  Icon(Icons.calendar_today),
                                                  SizedBox(width: 5),
                                                  Text("18/05/2022")
                                                ]),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(children: const [
                                                    Icon(Icons.star),
                                                    SizedBox(width: 5),
                                                    Text("4.3"),
                                                  ]),
                                                  const SizedBox(width: 5),
                                                  Row(children: const [
                                                    Icon(Icons.comment),
                                                    SizedBox(width: 5),
                                                    Text("สนทนา")
                                                  ]),
                                                ]),
                                          ]),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 10, right: 10),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Icon(Icons.share),
                                      ),
                                    )
                                  ]))))));
        });
  }
}
