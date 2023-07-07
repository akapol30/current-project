import 'package:flutter/material.dart';

class RecipeBundle {
  final int chefs, recipes;
  final String title, description, imageSrc;
  final Color color;

  RecipeBundle(
      {required this.chefs,
      required this.recipes,
      required this.title,
      required this.description,
      required this.imageSrc,
      required this.color});
}

// Demo list
List<RecipeBundle> recipeBundles = [
  RecipeBundle(
    chefs: 16,
    recipes: 95,
    title: "Food",
    description: "New and tasty recipes every minute",
    imageSrc: "assets/images/cook_new@2x.png",
    color: Color(0xFFD82D40),
  ),
  RecipeBundle(
    chefs: 8,
    recipes: 26,
    title: "Beverages",
    description: "New and tasty recipes every minute",
    imageSrc: "assets/images/best_2020@2x.png",
    color: Color(0xFF90AF17),
  ),
  RecipeBundle(
    chefs: 10,
    recipes: 43,
    title: "Dessert ",
    description: "New and tasty recipes every minute",
    imageSrc: "assets/images/food_court@2x.png",
    color: Color(0xFF2DBBD8),
  ),
];

class RestaurantBundle {
  final int user, store;
  final String title, description, imageSrc;
  final Color color;

  RestaurantBundle(
      {required this.user,
      required this.store,
      required this.title,
      required this.description,
      required this.imageSrc,
      required this.color});
}

// Demo list
List<RestaurantBundle> restaurantBundle = [
  RestaurantBundle(
    user: 16,
    store: 95,
    title: "คลาสสิก",
    description: "เปิด : เช้า - เย็น",
    imageSrc: "assets/images/cook_new@2x.png",
    color: const Color.fromARGB(255, 191, 116, 36),
  ),
  RestaurantBundle(
    user: 8,
    store: 26,
    title: "อินดี้",
    description: "เปิด : ดึก - เช้า",
    imageSrc: "assets/images/best_2020@2x.png",
    color: const Color.fromARGB(255, 39, 5, 49),
  ),
];

class TravelBundle {
  final post, travel;
  final String title, description, imageSrc;
  final Color color;

  TravelBundle(
      {required this.post,
      required this.travel,
      required this.title,
      required this.description,
      required this.imageSrc,
      required this.color});
}

// Demo list
List<TravelBundle> travelBundle = [
  TravelBundle(
    post: 16,
    travel: 95,
    title: "ผจญภัย",
    description:
        "กิจกรรมท้าทาย เช่น ปีนเขา , ดำน้ำ , เดินป่า , เครื่องเล่นต่างๆ",
    imageSrc: "assets/images/cook_new@2x.png",
    color: Colors.brown,
  ),
  TravelBundle(
    post: 8,
    travel: 26,
    title: "สรรหาของอร่อย",
    description: "ตลาดนัท , ร้านอาหาร , คาเฟ่",
    imageSrc: "assets/images/best_2020@2x.png",
    color: Colors.orange,
  ),
  TravelBundle(
    post: 8,
    travel: 26,
    title: "เชิงประวัติศาสตร์",
    description: "พิพิธภัณฑ์ , สถาปัตยกรรม , จิตรกรรม",
    imageSrc: "assets/images/best_2020@2x.png",
    color: Colors.lightBlue,
  ),
  TravelBundle(
    post: 8,
    travel: 26,
    title: "บรรยากาศสวยๆ",
    description: "ทะเล , ภูเขา , น้ำตก",
    imageSrc: "assets/images/best_2020@2x.png",
    color: Colors.lightGreen,
  ),
  TravelBundle(
    post: 8,
    travel: 26,
    title: "ช้อปปิ้ง",
    description: "ตลาดนัท , ห้าง",
    imageSrc: "assets/images/best_2020@2x.png",
    color: Colors.purple,
  ),
  TravelBundle(
    post: 8,
    travel: 26,
    title: "คอนเสิร์ต",
    description: "มีศิลปินมาร้องเพลงให้ฟังตามงานต่างๆ",
    imageSrc: "assets/images/best_2020@2x.png",
    color: Colors.black,
  ),
];

class PStorBundle {
  final post, amoutstor;
  final String title, description, imageSrc;
  final Color color;

  PStorBundle(
      {required this.post,
      required this.amoutstor,
      required this.title,
      required this.description,
      required this.imageSrc,
      required this.color});
}

// Demo list
List<PStorBundle> promoteStorBundle = [
  PStorBundle(
    post: 16,
    amoutstor: 95,
    title: "ร้านอาหาร",
    description: "ร้านอาหารทั่วไป",
    imageSrc: "assets/images/cook_new@2x.png",
    color: const Color(0xFFD82D40),
  ),
  PStorBundle(
    post: 8,
    amoutstor: 26,
    title: "ร้านเครื่องดื่ม",
    description: "ขายกาแฟ ชานม ร้านคาเฟ่",
    imageSrc: "assets/images/best_2020@2x.png",
    color: const Color(0xFF90AF17),
  ),
  PStorBundle(
    post: 8,
    amoutstor: 26,
    title: "ร้าน IT",
    description: "อุปกรณ์คอมพิวเตอร์ มือถือ",
    imageSrc: "assets/images/best_2020@2x.png",
    color: Colors.orange,
  ),
  PStorBundle(
    post: 8,
    amoutstor: 26,
    title: "ร้านเครื่องใช้ไฟฟ้า",
    description: "ทีวี ตู้เย็น เครื่องซักผ้า",
    imageSrc: "assets/images/best_2020@2x.png",
    color: Colors.pink,
  ),
  PStorBundle(
    post: 8,
    amoutstor: 26,
    title: "ร้านเสื้อผ้า",
    description: "เสื้อผ้าตามห้าง ร้านข้างทาง",
    imageSrc: "assets/images/best_2020@2x.png",
    color: Colors.brown,
  ),
  PStorBundle(
    post: 8,
    amoutstor: 26,
    title: "ร้านอื่นๆ",
    description: "ร้านที่ไม่จัดอยู่ในหมวดหมู่",
    imageSrc: "assets/images/best_2020@2x.png",
    color: Colors.lightBlue,
  ),
  PStorBundle(
    post: 8,
    amoutstor: 26,
    title: "ไม่มีหน้าร้าน",
    description: "ร้านค้าออนไลน์ต่างๆ",
    imageSrc: "assets/images/best_2020@2x.png",
    color: Colors.purple,
  ),
];
