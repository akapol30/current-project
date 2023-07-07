class Foodsql {
  String? id,
      foodname,
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

  Foodsql(
      {required this.foodname,
      required this.foodtype,
      required this.namepro,
      required this.picpro,
      required this.time,
      required this.dianamepro,
      required this.diapicpro,
      required this.diatime,
      required this.note,
      required this.flav,
      required this.region,
      required this.recipetype,
      required this.ingredient,
      required this.quantity,
      required this.uom,
      required this.step,
      required this.pic,
      required this.dianote,
      required this.nutrients,
      required this.nutweight,
      required this.nutpercent,
      required this.rating,
      required this.favorite,
      required this.id});
}