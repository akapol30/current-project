import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:json_annotation/json_annotation.dart';
part 'class_list_travel.g.dart';

@JsonSerializable(explicitToJson: true)
class MyCard {
  final String? id,
      locationname,
      locationtype,
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
      goodtime,
      childfee,
      adultfee,
      foreignerfees,
      province,
      email;
  final List<dynamic>? pictravel, dianote, activity, tel;
  final int? diafav;
  final double? rating, lat, lng;
  final bool? favorite;

  MyCard(
      {required this.id,
      required this.locationname,
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
      required this.pictravel,
      required this.goodtime,
      required this.dayopen,
      required this.dianote,
      required this.region,
      required this.dayoff,
      required this.tel,
      required this.locationtype,
      required this.flav,
      required this.diafav,
      required this.activity,
      required this.email,
      required this.adultfee,
      required this.lat,
      required this.lng,
      required this.childfee,
      required this.foreignerfees,
      required this.rating});

  factory MyCard.fromJson(Map<String, String> json) => _$MyCardFromJson(json);

  Map<String, dynamic> toJson() => _$MyCardToJson(this);
}

@JsonSerializable()
class Travel extends MyCard {
  @override
  final String? id,
      locationname,
      locationtype,
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
      goodtime,
      childfee,
      adultfee,
      foreignerfees,
      province,
      email;
  @override
  final List<dynamic>? pictravel, dianote, activity, tel;
  @override
  final int? diafav;
  @override
  final double? rating, lat, lng;
  @override
  final bool? favorite;
  Travel(
      {required this.id,
      required this.locationname,
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
      required this.pictravel,
      required this.goodtime,
      required this.dayopen,
      required this.dianote,
      required this.region,
      required this.dayoff,
      required this.tel,
      required this.locationtype,
      required this.flav,
      required this.diafav,
      required this.activity,
      required this.email,
      required this.adultfee,
      required this.lat,
      required this.lng,
      required this.childfee,
      required this.foreignerfees,
      required this.rating})
      : super(
            id: id,
            locationname: locationname,
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
            childfee: childfee,
            adultfee: adultfee,
            pictravel: pictravel,
            activity: activity,
            dianote: dianote,
            region: region,
            locationtype: locationtype,
            flav: flav,
            dayopen: dayopen,
            diafav: diafav,
            foreignerfees: foreignerfees,
            email: email,
            lat: lat,
            lng: lng,
            goodtime: goodtime,
            dayoff: dayoff,
            tel: tel,
            rating: rating);

  factory Travel.fromJson(Map<String, dynamic> json) => _$TravelFromJson(json);

  Map<String, dynamic> storetoJson() => _$TravelToJson(this);

  static List<Travel> travelList = [];

  static Future<List<Travel>> call() async {
    final travelRef = FirebaseFirestore.instance
        .collection('ListTravelNorth')
        .withConverter<Travel>(
          fromFirestore: (snapshot, _) => Travel.fromJson(snapshot.data()!),
          toFirestore: (travel, _) => travel.storetoJson(),
        );
    try {
      await travelRef.get().then((QuerySnapshot snapshot) => {
            if (travelList.length != snapshot.docs.length)
              {
                snapshot.docs.forEach((doc) {
                  travelList.add(Travel(
                    id: doc["Tid"],
                    locationname: doc["Tlocationname"],
                    province: doc["Tprovince"],
                    namepro: doc["Tnamepro"],
                    picpro: doc["Tpicpro"],
                    timepost: doc["Ttimepost"],
                    timeopen: doc["Ttimeopen"],
                    favorite: doc["Tfavorite"],
                    dianamepro: doc["Tdialoguename"],
                    diapicpro: doc["Tdialoguepic"],
                    diatime: doc["Tdialoguetime"],
                    note: doc["Tnote"],
                    dayopen: doc["Tdayopen"],
                    dayoff: doc["Tdayoff"],
                    pictravel: doc["Tpictravel"],
                    goodtime: doc["Tgoodtime"],
                    activity: doc["Tactivity"],
                    dianote: doc["Tdialoguenote"],
                    region: doc["Tregion"],
                    locationtype: doc["Tlocationtype"],
                    diafav: doc["Tdiafav"].toInt(),
                    adultfee: doc["Tadultfee"],
                    email: doc["Temail"],
                    childfee: doc["Tchildfee"],
                    lat: doc["Tlat"].toDouble,
                    lng: doc["Tlng"].toDouble,
                    foreignerfees: doc["Tforeignerfees"],
                    rating: double.parse(doc["TRating"]),
                    flav: doc["Tflav"],
                    tel: doc["Ttel"],
                  ));
                })
              }
          });
    } catch (e) {
      print(e);
    }
    return travelList;
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
