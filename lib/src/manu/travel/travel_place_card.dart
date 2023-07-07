import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_towin/src/manu/travel/TravelSpot.dart';
import 'package:project_towin/src/manu/travel/User.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    Key? key,
    required this.travelSport,
    this.isFullCard = false,
    required this.keyLock,
    required this.press,
  }) : super(key: key);

  final TravelSpot travelSport;
  final bool isFullCard;
  final GestureTapCallback press;
  final bool keyLock;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 158,
        child: GestureDetector(
          onTap: press,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: isFullCard ? 1.09 : 1.29,
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      image: DecorationImage(
                          image: AssetImage(travelSport.image),
                          fit: BoxFit.cover),
                    ),
                    child: ListTile(
                      trailing: keyLock == true
                          ? const Icon(Icons.lock)
                          : const Icon(Icons.key),
                    )),
              ),
              Container(
                width: 158,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      travelSport.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: isFullCard ? 17 : 12,
                      ),
                    ),
                    if (isFullCard)
                      Text(
                        travelSport.date.day.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    if (isFullCard)
                      Text(
                        "${DateFormat.MMMM().format(travelSport.date)} ${travelSport.date.year}",
                      ),
                    Travelers(users: travelSport.users),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class Travelers extends StatelessWidget {
  const Travelers({Key? key, required this.users}) : super(key: key);

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    int totalUser = 0;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 30,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ...List.generate(
                users.length,
                (index) {
                  totalUser++;
                  return Positioned(
                    left: (22 * index).toDouble(),
                    child: buildTravelerFace(index),
                  );
                },
              ),
            ],
          ),
        ),
        Text("มีทั้งหมด ${totalUser} คน"),
      ],
    );
  }

  ClipOval buildTravelerFace(int index) {
    return ClipOval(
      child: Image.asset(
        users[index].image,
        height: 28,
        width: 28,
        fit: BoxFit.cover,
      ),
    );
  }
}
