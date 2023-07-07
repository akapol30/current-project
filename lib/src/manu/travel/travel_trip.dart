import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:project_towin/src/manu/travel/TravelSpot.dart';
import 'package:project_towin/src/manu/travel/travel_keylock.dart';
import 'package:project_towin/src/manu/travel/travel_place_card.dart';

class TripGroupNorth extends StatelessWidget {
  const TripGroupNorth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(200),
            child: AppBar(
              backgroundColor: Colors.transparent,
              flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/Magical_World.png"),
                          fit: BoxFit.fill))),
              elevation: 0,
              title: const Text(
                'Events Group',
                style: TextStyle(color: Color(0xFF5E5E5E)),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon:
                      ClipOval(child: Image.asset("assets/images/profile.png")),
                  onPressed: () {},
                )
              ],
            )),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: (25)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 25,
                  children: [
                    ...List.generate(
                      travelSpots.length,
                      (index) => PlaceCard(
                        travelSport: travelSpots[index],
                        isFullCard: true,
                        keyLock: travelSpots[index].keyLock,
                        press: () {
                          if (travelSpots[index].keyLock == true) {
                            showDialog(
                              context: context,
                              builder: (_) =>
                                  Password(pass: travelSpots[index].password),
                            );
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const KeyLock()));
                          }
                        },
                      ),
                    ),
                    const AddNewPlaceCard(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class AddNewPlaceCard extends StatelessWidget {
  const AddNewPlaceCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 158,
      decoration: BoxDecoration(
        color: const Color(0xFF6A6C93).withOpacity(0.09),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: const Color(0xFFEBE8F6),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 53,
            width: 53,
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => const CreatePlace(),
                );
              },
              child: const Icon(
                Icons.add,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),
          const Text(
            "Add New Place",
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class Password extends StatefulWidget {
  const Password({super.key, required this.pass});
  final int pass;
  @override
  State<StatefulWidget> createState() => PasswordState();
}

class PasswordState extends State<Password>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);

    controller!.addListener(() {
      setState(() {});
    });

    controller!.forward();
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation!,
          child: Container(
            height: 160,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'จำนวน',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (widget.pass.toString() != value) {
                          isChecked = false;
                          return 'รหัสไม่ถูกต้อง';
                        }
                        isChecked = true;
                        return null;
                      },
                    )),
                ElevatedButton(
                  onPressed: () {
                    if (isChecked) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => const KeyLock()));
                    }
                  },
                  child: Text("ยืนยัน"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreatePlace extends StatefulWidget {
  const CreatePlace({super.key});

  @override
  State<StatefulWidget> createState() => CreatePlaceState();
}

class CreatePlaceState extends State<CreatePlace>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);

    controller!.addListener(() {
      setState(() {});
    });

    controller!.forward();
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation!,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Trip Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    labelText: 'Date of Trip',
                    border: OutlineInputBorder(),
                  ),
                ),
                Row(children: [
                  Checkbox(
                      value: isChecked,
                      activeColor: Colors.amber,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      }),
                  const Text(
                    "Create Password",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ]),
                if (isChecked == true)
                  TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          padding: const EdgeInsets.symmetric(horizontal: 16)),
                      onPressed: () {},
                      child: const Text('Post'),
                    ))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
