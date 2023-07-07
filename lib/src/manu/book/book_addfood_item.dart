import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:project_towin/src/modelclass/model.dart';

class ProductRepository {
  final _fireCloud = FirebaseFirestore.instance.collection("products");

  Future<void> create({required String name, required String price}) async {
    try {
      await _fireCloud.add({"name": name, "price": price});
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error ${e.code}: ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ProductModel>> get() async {
    List<ProductModel> proList = [];
    try {
      final pro = await FirebaseFirestore.instance.collection("products").get();
      pro.docs.forEach((element) {
        return proList.add(ProductModel.fromJson(element.data()));
      });
      return proList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error ${e.code}: ${e.message}");
      }
      return proList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
