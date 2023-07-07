import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:json_annotation/json_annotation.dart';
part 'class_list_food.g.dart';

@JsonSerializable(explicitToJson: true)
class MyCard {
  String? foodname,
      foodtype,
      namepro,
      picpro,
      time,
      dianamepro,
      diapicpro,
      diatime,
      note,
      flav,
      region,
      id,
      recipetype;
  List<dynamic>? ingredient,
      quantity,
      uom,
      step,
      pic,
      dianote,
      nutrients,
      nutweight,
      nutpercent;
  double? rating;
  bool? favorite;

  MyCard(
      {required this.id,
      required this.foodname,
      required this.foodtype,
      required this.namepro,
      required this.picpro,
      required this.time,
      required this.favorite,
      required this.dianamepro,
      required this.diapicpro,
      required this.diatime,
      required this.note,
      required this.ingredient,
      required this.quantity,
      required this.uom,
      required this.step,
      required this.pic,
      required this.dianote,
      required this.region,
      required this.recipetype,
      required this.nutrients,
      required this.nutweight,
      required this.nutpercent,
      required this.flav,
      required this.rating});

  factory MyCard.fromJson(Map<String, String> json) => _$MyCardFromJson(json);

  Map<String, dynamic> toJson() => _$MyCardToJson(this);
}

@JsonSerializable()
class Food extends MyCard {
  @override
  String? foodname,
      foodtype,
      namepro,
      picpro,
      time,
      dianamepro,
      diapicpro,
      diatime,
      note,
      flav,
      region,
      recipetype,
      id;
  @override
  final List<dynamic>? ingredient,
      quantity,
      uom,
      step,
      pic,
      dianote,
      nutrients,
      nutweight,
      nutpercent;

  @override
  double? rating;
  @override
  bool? favorite;

  Food(
      {this.id,
      this.foodname,
      this.foodtype,
      this.namepro,
      this.picpro,
      this.time,
      this.favorite,
      this.dianamepro,
      this.diapicpro,
      this.diatime,
      this.note,
      this.ingredient,
      this.quantity,
      this.uom,
      this.step,
      this.pic,
      this.dianote,
      this.region,
      this.recipetype,
      this.flav,
      this.nutrients,
      this.nutweight,
      this.nutpercent,
      this.rating})
      : super(
            id: id,
            foodname: foodname,
            foodtype: foodtype,
            namepro: namepro,
            picpro: picpro,
            time: time,
            favorite: favorite,
            dianamepro: dianamepro,
            diapicpro: diapicpro,
            diatime: diatime,
            note: note,
            ingredient: ingredient,
            quantity: quantity,
            uom: uom,
            step: step,
            pic: pic,
            dianote: dianote,
            region: region,
            recipetype: recipetype,
            flav: flav,
            nutrients: nutrients,
            nutweight: nutweight,
            nutpercent: nutpercent,
            rating: rating);

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);

  Map<String, dynamic> foodtoJson() => _$FoodToJson(this);

  static List<Food> foodList = [];

  static Future<List<Food>> call() async {
    final foodRef = FirebaseFirestore.instance
        .collection('ListRecipesNorth')
        .withConverter<Food>(
          fromFirestore: (snapshot, _) => Food.fromJson(snapshot.data()!),
          toFirestore: (food, _) => food.foodtoJson(),
        );

    await foodRef.get().then((QuerySnapshot snapshot) => {
          if (foodList.length != snapshot.docs.length)
            {
              snapshot.docs.forEach((doc) {
                foodList.add(Food(
                  id: doc["Bid"],
                  foodname: doc["Bfoodname"],
                  foodtype: doc["Bfoodtype"],
                  namepro: doc["Bnamepro"],
                  picpro: doc["Bpicpro"],
                  time: doc["Btime"],
                  favorite: doc["Bfavorite"],
                  dianamepro: doc["Bdialoguename"],
                  diapicpro: doc["Bdialoguepic"],
                  diatime: doc["Bdialoguetime"],
                  note: doc["Bnote"],
                  ingredient: doc["Bingredient"],
                  quantity: doc["Bquantity"],
                  uom: doc["Buom"],
                  step: doc["Bstep"],
                  pic: doc["Bpicfood"],
                  dianote: doc["Bdialoguenote"],
                  region: doc["Bregion"],
                  recipetype: doc["Brecipetype"],
                  rating: doc["BRating"].toDouble(),
                  flav: doc["Bflav"],
                  nutrients: doc["Bnutname"],
                  nutweight: doc["Bnutweight"],
                  nutpercent: doc["Bnutpercent"],
                ));
              })
            }
        });

    return foodList;
  }

  static List<Food> foodListfav = [];
  static Future<List<Food>> getDatafavorite() async {
    final foodRef = FirebaseFirestore.instance
        .collection('ListRecipesNorth')
        .withConverter<Food>(
          fromFirestore: (snapshot, _) => Food.fromJson(snapshot.data()!),
          toFirestore: (food, _) => food.foodtoJson(),
        );

    await foodRef
        .where("Bfavorite", isEqualTo: true)
        .get()
        .then((QuerySnapshot snapshot) => {
              if (foodListfav.length != snapshot.docs.length)
                {
                  snapshot.docs.forEach((doc) {
                    foodListfav.add(Food(
                      id: doc["Bid"],
                      foodname: doc["Bfoodname"],
                      foodtype: doc["Bfoodtype"],
                      namepro: doc["Bnamepro"],
                      picpro: doc["Bpicpro"],
                      time: doc["Btime"],
                      favorite: doc["Bfavorite"],
                      dianamepro: doc["Bdialoguename"],
                      diapicpro: doc["Bdialoguepic"],
                      diatime: doc["Bdialoguetime"],
                      note: doc["Bnote"],
                      ingredient: doc["Bingredient"],
                      quantity: doc["Bquantity"],
                      uom: doc["Buom"],
                      step: doc["Bstep"],
                      pic: doc["Bpicfood"],
                      dianote: doc["Bdialoguenote"],
                      region: doc["Bregion"],
                      recipetype: doc["Brecipetype"],
                      rating: doc["BRating"].toDouble(),
                      flav: doc["Bflav"],
                      nutrients: doc["Bnutname"],
                      nutweight: doc["Bnutweight"],
                      nutpercent: doc["Bnutpercent"],
                    ));
                  })
                }
            });

    return foodListfav;
  }
}
/*
@JsonSerializable()
class Beverage extends MyCard {
  @override
  final String id,
      foodname,
      foodtype,
      namepro,
      picpro,
      time,
      favorite,
      dianamepro,
      diapicpro,
      diatime,
      note,
      desc,
      flav,
      region,
      recipetype;
  @override
  final List<String> ingredient, quantity, uom, step, pic, dianote;

  @override
  final double rating;
  @override
  Beverage(
      {required this.id,
      required this.foodname,
      required this.foodtype,
      required this.namepro,
      required this.picpro,
      required this.time,
      required this.favorite,
      required this.dianamepro,
      required this.diapicpro,
      required this.diatime,
      required this.note,
      required this.ingredient,
      required this.quantity,
      required this.uom,
      required this.step,
      required this.pic,
      required this.dianote,
      required this.region,
      required this.recipetype,
      required this.desc,
      required this.flav,
      required this.rating})
      : super(
            id: id,
            foodname: foodname,
            foodtype: foodtype,
            namepro: namepro,
            picpro: picpro,
            time: time,
            favorite: favorite,
            dianamepro: dianamepro,
            diapicpro: diapicpro,
            diatime: diatime,
            note: note,
            ingredient: ingredient,
            quantity: quantity,
            uom: uom,
            step: step,
            pic: pic,
            dianote: dianote,
            region: region,
            recipetype: recipetype,
            desc: desc,
            flav: flav,
            rating: rating);

  factory Beverage.fromJson(Map<String, dynamic> json) =>
      _$BeverageFromJson(json);

  Map<String, dynamic> foodtoJson() => _$BeverageToJson(this);
  static var beverageList = [];
}
*/
