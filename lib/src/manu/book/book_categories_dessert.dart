import 'package:flutter/material.dart';

// Our Category List need StateFullWidget
// I can use Provider on it, Then we dont need StatefulWidget
class CategoriesDessert extends StatefulWidget {
  const CategoriesDessert({Key? key}) : super(key: key);

  @override
  State<CategoriesDessert> createState() => _CategoriesDessertState();
}

class _CategoriesDessertState extends State<CategoriesDessert> {
 
  List<String> categoriesDessert =["ทั้งหมด", "เบเกอรี/เค้ก", "ของหวาน", "คุ๊กกี้", "ไอศกรีม"];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 35, // 35
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoriesDessert.length,
          itemBuilder: (context, index) => buildCategoriItem(index),
        ),
      ),
    );
  }
  Widget buildCategoriItem(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 20),
        padding: const EdgeInsets.symmetric(
          horizontal: 20, //20
          vertical: 5, //5
        ),
        decoration: BoxDecoration(
            color:
                selectedIndex == index ?  Colors.yellow[100] : Colors.grey,
            borderRadius: BorderRadius.circular(
              16, // 16
            )),
        child: Text(
          categoriesDessert[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selectedIndex == index ? Colors.red : Colors.white,
          ),
        ),
      ),
    );
  }
}
