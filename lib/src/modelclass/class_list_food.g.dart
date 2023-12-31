// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_list_food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyCard _$MyCardFromJson(Map<String, dynamic> json) => MyCard(
      id: json['id'] as String?,
      foodname: json['foodname'] as String?,
      foodtype: json['foodtype'] as String?,
      namepro: json['namepro'] as String?,
      picpro: json['picpro'] as String?,
      time: json['time'] as String?,
      favorite: json['favorite'] as bool?,
      dianamepro: json['dianamepro'] as String?,
      diapicpro: json['diapicpro'] as String?,
      diatime: json['diatime'] as String?,
      note: json['note'] as String?,
      ingredient: json['ingredient'] as List<dynamic>?,
      quantity: json['quantity'] as List<dynamic>?,
      uom: json['uom'] as List<dynamic>?,
      step: json['step'] as List<dynamic>?,
      pic: json['pic'] as List<dynamic>?,
      dianote: json['dianote'] as List<dynamic>?,
      region: json['region'] as String?,
      recipetype: json['recipetype'] as String?,
      nutrients: json['nutrients'] as List<dynamic>?,
      nutweight: json['nutweight'] as List<dynamic>?,
      nutpercent: json['nutpercent'] as List<dynamic>?,
      flav: json['flav'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MyCardToJson(MyCard instance) => <String, dynamic>{
      'foodname': instance.foodname,
      'foodtype': instance.foodtype,
      'namepro': instance.namepro,
      'picpro': instance.picpro,
      'time': instance.time,
      'dianamepro': instance.dianamepro,
      'diapicpro': instance.diapicpro,
      'diatime': instance.diatime,
      'note': instance.note,
      'flav': instance.flav,
      'region': instance.region,
      'id': instance.id,
      'recipetype': instance.recipetype,
      'ingredient': instance.ingredient,
      'quantity': instance.quantity,
      'uom': instance.uom,
      'step': instance.step,
      'pic': instance.pic,
      'dianote': instance.dianote,
      'nutrients': instance.nutrients,
      'nutweight': instance.nutweight,
      'nutpercent': instance.nutpercent,
      'rating': instance.rating,
      'favorite': instance.favorite,
    };

Food _$FoodFromJson(Map<String, dynamic> json) => Food(
      id: json['id'] as String?,
      foodname: json['foodname'] as String?,
      foodtype: json['foodtype'] as String?,
      namepro: json['namepro'] as String?,
      picpro: json['picpro'] as String?,
      time: json['time'] as String?,
      favorite: json['favorite'] as bool?,
      dianamepro: json['dianamepro'] as String?,
      diapicpro: json['diapicpro'] as String?,
      diatime: json['diatime'] as String?,
      note: json['note'] as String?,
      ingredient: json['ingredient'] as List<dynamic>?,
      quantity: json['quantity'] as List<dynamic>?,
      uom: json['uom'] as List<dynamic>?,
      step: json['step'] as List<dynamic>?,
      pic: json['pic'] as List<dynamic>?,
      dianote: json['dianote'] as List<dynamic>?,
      region: json['region'] as String?,
      recipetype: json['recipetype'] as String?,
      flav: json['flav'] as String?,
      nutrients: json['nutrients'] as List<dynamic>?,
      nutweight: json['nutweight'] as List<dynamic>?,
      nutpercent: json['nutpercent'] as List<dynamic>?,
      rating: (json['rating'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      'foodname': instance.foodname,
      'foodtype': instance.foodtype,
      'namepro': instance.namepro,
      'picpro': instance.picpro,
      'time': instance.time,
      'dianamepro': instance.dianamepro,
      'diapicpro': instance.diapicpro,
      'diatime': instance.diatime,
      'note': instance.note,
      'flav': instance.flav,
      'region': instance.region,
      'recipetype': instance.recipetype,
      'id': instance.id,
      'ingredient': instance.ingredient,
      'quantity': instance.quantity,
      'uom': instance.uom,
      'step': instance.step,
      'pic': instance.pic,
      'dianote': instance.dianote,
      'nutrients': instance.nutrients,
      'nutweight': instance.nutweight,
      'nutpercent': instance.nutpercent,
      'rating': instance.rating,
      'favorite': instance.favorite,
    };
