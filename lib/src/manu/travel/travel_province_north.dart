import 'package:flutter/material.dart';

// Our Category List need StateFullWidget
// I can use Provider on it, Then we dont need StatefulWidget
class TProvinceNorth extends StatefulWidget {
  const TProvinceNorth({Key? key}) : super(key: key);

  @override
  State<TProvinceNorth> createState() => _TProvinceNorthState();
}

class _TProvinceNorthState extends State<TProvinceNorth> {
  List<String> categoriesFood = [
    "ทั้งหมด",
    "เชียงราย",
    "เชียงใหม่",
    "น่าน",
    "พะเยา",
    "แม่ฮ่องสอน",
    "แพร่",
    "ลำปาง",
    "ลำพูน",
    "ตาก",
    "อุตรดิตถ์",
    "พิษณุโลก",
    "สุโขทัย",
    "เพชรบูรณ์",
    "พิจิตร",
    "กำแพงเพชร",
    "นครสวรรค์",
    "อุทัยธานี"
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 35, // 35
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoriesFood.length,
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
            color: selectedIndex == index ? Colors.yellow[100] : Colors.grey,
            borderRadius: BorderRadius.circular(
              16, // 16
            )),
        child: Text(
          categoriesFood[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selectedIndex == index ? Colors.red : Colors.white,
          ),
        ),
      ),
    );
  }
}
