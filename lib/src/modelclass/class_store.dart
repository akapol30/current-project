class storesql {
  String? id,
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
  List<dynamic>? foodname,
      fooddes,
      picStore,
      picfood,
      dianote,
      price,
      diapicdes,
      tel,
      user,
      url;
  int? diafav;
  double? rating, lat, lng;
  bool? favorite;
  storesql(
      {required this.id,
      required this.storename,
      required this.storetype,
      required this.namepro,
      required this.picpro,
      required this.timepost,
      required this.timeopen,
      required this.dayopen,
      required this.dianamepro,
      required this.diapicpro,
      required this.diatime,
      required this.note,
      required this.flav,
      required this.region,
      required this.dayoff,
      required this.province,
      required this.email,
      required this.foodname,
      required this.fooddes,
      required this.picStore,
      required this.picfood,
      required this.dianote,
      required this.price,
      required this.diapicdes,
      required this.tel,
      required this.user,
      required this.diafav,
      required this.rating,
      required this.lat,
      required this.lng,
      required this.url,
      required this.favorite});
}
