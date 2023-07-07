import 'package:flutter/material.dart';

import 'package:project_towin/src/manu/travel/TravelSpot.dart';
import 'package:project_towin/src/manu/travel/User.dart';

class InPlaceCard extends StatelessWidget {
  const InPlaceCard({
    Key? key,
    required this.travelSport,
    this.isFullCard = false,
  }) : super(key: key);

  final TravelSpot travelSport;
  final bool isFullCard;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(children: [
        Travelers(
          users: travelSport.users,
          press: () {},
        ),
      ]),
    );
  }
}

class Travelers extends StatelessWidget {
  const Travelers({Key? key, required this.users, required press})
      : super(key: key);

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    int totalUser = 0;
    return Column(
      children: [
        Container(
          color: Colors.yellow.shade100,
          width: double.infinity,
          height: 70,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ...List.generate(
                users.length,
                (index) {
                  totalUser++;
                  return Positioned(
                    left: (40 * index).toDouble(),
                    child: buildTravelerFace(index),
                  );
                },
              ),
            ],
          ),
        ),
        Container(
            alignment: Alignment.center,
            color: Colors.yellow.shade100,
            width: double.infinity,
            height: 30,
            child: Text("ทั้งหมด ${totalUser} คน")),
      ],
    );
  }

  ClipOval buildTravelerFace(int index) {
    return ClipOval(
      child: Image.asset(
        users[index].image,
        height: 50,
        width: 50,
        fit: BoxFit.cover,
      ),
    );
  }
}
