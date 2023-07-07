import 'package:flutter/material.dart';
import 'package:project_towin/src/manu/book/book_detail.dart';
import 'package:project_towin/src/modelclass/class_list_food.dart';

class BookAllListPopular extends StatefulWidget {
  const BookAllListPopular({Key? key}) : super(key: key);

  @override
  State<BookAllListPopular> createState() => _BookAllListPopularState();
}

class _BookAllListPopularState extends State<BookAllListPopular> {
  String dropdownValue = 'TH';
  var body = Container(
    color: Colors.white,
    child: GridView.builder(
        shrinkWrap: false,
        itemCount: Food.foodList.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SlidingUpPanelExampleBook(
                              recipe: Food.foodList[index],
                            )));
              },
              child: Card(
                color: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                          child: Hero(
                            tag: Food.foodList[index].id!,
                            child: FadeInImage(
                              image: NetworkImage(Food.foodList[index].pic![0]),
                              fit: BoxFit.cover,
                              placeholder:
                                  const AssetImage('assets/images/loading.gif'),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          Food.foodList[index].foodname!,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('TOP 10 Menu'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {
                //Navigator.of(context).pushReplacement(MaterialPageRoute(
                //   builder: (BuildContext context) => MyApp()));
              },
            ),
            Align(
                alignment: Alignment.center,
                child: DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['TH', 'EN', 'CN', 'TW']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
          ]),
      body: body,
    );
  }
}
