import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:json_annotation/json_annotation.dart';
part 'class_list_store.g.dart';

@JsonSerializable(explicitToJson: true)
class MyCard {
  final String? id,
      storename,
      storetype,
      namepro,
      picpro,
      timepost,
      timeopen,
      dayopen,
      dianamepro,
      diapicpro,
      diatime,
      note,
      flav,
      region,
      dayoff,
      province,
      email;
  final List<dynamic>? foodname,
      fooddes,
      picStore,
      picfood,
      dianote,
      price,
      diapicdes,
      tel,
      user,
      url;
  final int? diafav;
  final double? rating, lat, lng;
  final bool? favorite;

  MyCard(
      {required this.id,
      required this.storename,
      required this.province,
      required this.namepro,
      required this.picpro,
      required this.timepost,
      required this.timeopen,
      required this.favorite,
      required this.dianamepro,
      required this.diapicpro,
      required this.diatime,
      required this.note,
      required this.picStore,
      required this.foodname,
      required this.picfood,
      required this.price,
      required this.dayopen,
      required this.dianote,
      required this.region,
      required this.dayoff,
      required this.tel,
      required this.storetype,
      required this.flav,
      required this.diafav,
      required this.diapicdes,
      required this.email,
      required this.fooddes,
      required this.lat,
      required this.lng,
      required this.user,
      required this.url,
      required this.rating});

  factory MyCard.fromJson(Map<String, String> json) => _$MyCardFromJson(json);

  Map<String, dynamic> toJson() => _$MyCardToJson(this);
}

@JsonSerializable()
class Store extends MyCard {
  @override
  final String? id,
      storename,
      storetype,
      namepro,
      picpro,
      timepost,
      timeopen,
      dayopen,
      dianamepro,
      diapicpro,
      diatime,
      note,
      flav,
      region,
      dayoff,
      province,
      email;

  @override
  final List<dynamic>? foodname,
      fooddes,
      picStore,
      picfood,
      dianote,
      price,
      diapicdes,
      tel,
      user,
      url;
  @override
  final int? diafav;

  @override
  final double? rating, lat, lng;
  @override
  final bool? favorite;

  Store(
      {required this.id,
      required this.storename,
      required this.province,
      required this.namepro,
      required this.picpro,
      required this.timepost,
      required this.timeopen,
      required this.favorite,
      required this.dianamepro,
      required this.diapicpro,
      required this.diatime,
      required this.note,
      required this.picStore,
      required this.foodname,
      required this.picfood,
      required this.price,
      required this.dayopen,
      required this.dianote,
      required this.region,
      required this.dayoff,
      required this.tel,
      required this.storetype,
      required this.flav,
      required this.diafav,
      required this.diapicdes,
      required this.email,
      required this.fooddes,
      required this.lat,
      required this.lng,
      required this.user,
      required this.url,
      required this.rating})
      : super(
            id: id,
            storename: storename,
            province: province,
            namepro: namepro,
            picpro: picpro,
            timeopen: timeopen,
            timepost: timepost,
            favorite: favorite,
            dianamepro: dianamepro,
            diapicpro: diapicpro,
            diatime: diatime,
            note: note,
            foodname: foodname,
            picStore: picStore,
            picfood: picfood,
            price: price,
            dianote: dianote,
            region: region,
            storetype: storetype,
            flav: flav,
            dayopen: dayopen,
            diafav: diafav,
            diapicdes: diapicdes,
            email: email,
            fooddes: fooddes,
            lat: lat,
            lng: lng,
            user: user,
            dayoff: dayoff,
            tel: tel,
            url: url,
            rating: rating);

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  Map<String, dynamic> storetoJson() => _$StoreToJson(this);

  static List<Store> storeList = [];
  static List<Store> youtubeList = [];

  static Future<List<Store>> call() async {
    final storeRef = FirebaseFirestore.instance
        .collection('ListStoreNorth')
        .withConverter<Store>(
          fromFirestore: (snapshot, _) => Store.fromJson(snapshot.data()!),
          toFirestore: (store, _) => store.storetoJson(),
        );

    try {
      await storeRef.get().then((QuerySnapshot snapshot) => {
            if (storeList.length != snapshot.docs.length)
              {
                snapshot.docs.forEach((doc) {
                  storeList.add(Store(
                    id: doc["Sid"],
                    storename: doc["Sstorename"],
                    province: doc["Sprovince"],
                    namepro: doc["Snamepro"],
                    picpro: doc["Spicpro"],
                    timepost: doc["Stimepost"],
                    timeopen: doc["Stimeopen"],
                    favorite: doc["Sfavorite"],
                    dianamepro: doc["Sdialoguename"],
                    diapicpro: doc["Sdialoguepic"],
                    diatime: doc["Sdialoguetime"],
                    note: doc["Snote"],
                    dayopen: doc["Sdayopen"],
                    dayoff: doc["Sdayoff"],
                    foodname: doc["Sfoodname"],
                    picStore: doc["Spicstore"],
                    picfood: doc["Spicfood"],
                    dianote: doc["Sdialoguenote"],
                    region: doc["Sregion"],
                    storetype: doc["Sstoretype"],
                    diafav: doc["Sdiafav"].toInt(),
                    diapicdes: doc["Sdiapicdes"],
                    email: doc["Semail"],
                    fooddes: doc["Sfooddes"],
                    lat: doc["Slat"].toDouble,
                    lng: doc["Slng"].toDouble,
                    user: doc["Suser"],
                    rating: double.parse(doc["SRating"]),
                    flav: doc["Sflav"],
                    tel: doc["Stel"],
                    price: doc["Sprice"],
                    url: doc["Surl"],
                  ));
                })
              }
          });
    } catch (e) {
      print(e);
    }
    return storeList;
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
