import 'package:project_towin/src/manu/travel/User.dart';

class TravelSpot {
  final String name, image;
  final DateTime date;
  final List<User> users;
  final bool keyLock;
  final int password;
  TravelSpot(
      {required this.users,
      required this.name,
      required this.image,
      required this.date,
      required this.keyLock,
      required this.password});
}

List<TravelSpot> travelSpots = [
  TravelSpot(
      users: users..shuffle(),
      name: "Red Mountains",
      image: "assets/images/Red_Mountains.png",
      date: DateTime(2020, 10, 15),
      keyLock: true,
      password: 123456),
  TravelSpot(
      users: users..shuffle(),
      name: "Megical World",
      image: "assets/images/Magical_World.png",
      date: DateTime(2020, 3, 10),
      keyLock: false,
      password: 0),
  TravelSpot(
      users: users..shuffle(),
      name: "Red Mountains",
      image: "assets/images/Red_Mountains.png",
      date: DateTime(2020, 10, 15),
      keyLock: true,
      password: 456789),
];

List<User> users = [
  user1,
  user2,
  user3,
  user4,
  user5,
  user6,
  user7,
  user8,
  user9,
  user10,
  user11,
  user12,
  user13,
  user14,
  user15,
  user16,
  user17,
  user18,
  user19,
  user20
];
