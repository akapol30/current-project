import 'package:flutter/material.dart';

// Our Category List need StateFullWidget
// I can use Provider on it, Then we dont need StatefulWidget
class CategoriesBeverage extends StatefulWidget {
  const CategoriesBeverage({Key? key}) : super(key: key);

  @override
  State<CategoriesBeverage> createState() => _CategoriesBeverageState();
}

class _CategoriesBeverageState extends State<CategoriesBeverage> {
 
  List<String> categoriesBeverage =["ทั้งหมด", "น้ำผลไม้", "ชานมไข่มุก", "กาแฟ", "เครื่องดื่มแอลกอฮอล์"];
  
  
  
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 35, // 35
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoriesBeverage.length,
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
          categoriesBeverage[index],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: selectedIndex == index ? Colors.red : Colors.white,
          ),
        ),
      ),
    );
  }
}
