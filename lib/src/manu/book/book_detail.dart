import 'package:flutter/material.dart';
import 'package:project_towin/src/Feature/profile.dart';

import 'package:project_towin/src/manu/book/book_converse.dart';
import 'package:project_towin/src/manu/book/book_tool.dart';

import 'package:project_towin/src/manu/travel/User.dart';

import 'package:project_towin/src/modelclass/class_list_food.dart';

import 'package:project_towin/src/page/homepage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';

class SlidingUpPanelExampleBook extends StatelessWidget {
  final Food recipe;
  const SlidingUpPanelExampleBook({super.key, required this.recipe});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.grey[200],
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.black,
    ));

    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {
            //Navigator.of(context).pushReplacement(MaterialPageRoute(
            //   builder: (BuildContext context) => MyApp()));
          },
        ),
      ], title: Text("${recipe.foodname!}"), centerTitle: true),
      body: DetailPage(recipe: recipe),
    );
  }
}

class DetailPage extends StatefulWidget {
  final Food recipe;
  const DetailPage({super.key, required this.recipe});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  static List<String> listBanners = [];
  void getImage(Food food) {
    if (food.pic!.length != listBanners.length) {
      int count = food.pic!.length;
      for (int i = 0; i <= count - 1; i++) {
        listBanners.add(
          food.pic![i],
        );
      }
    }
  }

  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  final double _panelHeightClosed = 95.0;
  double foodrating = 0;
  double foodratingcal = 0;
  bool foodflat = true;
  int foodperson = 0;
  double foodresult = 0;
  String ratingvalue = '';
  bool isFav = false;

  @override
  void initState() {
    super.initState();

    _fabHeight = _initFabHeight;
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;

    return Scaffold(
        body: Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            color: Colors.amber,
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            body: _body(widget.recipe),
            panelBuilder: (sc) => _panel(sc, widget.recipe),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            onPanelSlide: (double pos) => setState(() {
              _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                  _initFabHeight;
            }),
          ),
          Positioned(
              top: 0,
              child: ClipRRect(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).padding.top,
                        color: Colors.transparent,
                      )))),
        ],
      ),
    ));
  }

  Widget _panel(ScrollController sc, Food recipe) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          controller: sc,
          children: <Widget>[
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            const SizedBox(
              height: 18.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  "รายละเอียด",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const Profile()));
              },
              child: ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(user.photoURL!),
                ),
                title: Container(
                  alignment: Alignment.center,
                  height: 35,
                  width: double.infinity,
                  color: Colors.red.shade200,
                  child: Text(
                    user.displayName!,
                    // _docdata!["B4namepro"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 16)),
                    onPressed: () {},
                    child: const Text('Update Data',
                        style: TextStyle(color: Colors.white))),
                subtitle: AddEdit(users: []),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buttonfav("Favorite", Icons.favorite, Colors.blue, () {
                  setState(() {
                    isFav = !isFav;
                  });
                }),
                _button("Nutrition", Icons.restaurant, Colors.red, () {}),
                _button("Video", Icons.video_collection, Colors.red, () {}),
                _button("Discuss", Icons.comment, Colors.orange, () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const BookConverseNorth()));
                }),
                _button("share", Icons.share, Colors.green, () {}),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text("โภชนาการ",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                      )),
                  const SizedBox(
                    height: 15.0,
                  ),
                  NutritionWidget(
                    nutrients: recipe,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text('Ingredients',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  const SizedBox(
                    height: 15.0,
                  ),
                  IngredientsWidget(
                    dataing: recipe,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text('Steps',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  const SizedBox(
                    height: 15.0,
                  ),
                  RecipeSteps(
                    steps: recipe.step!,
                  ),
                  Text(recipe.note!,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 16)),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _buttonfav(
      String label, IconData icon, Color color, VoidCallback press) {
    return Column(
      children: <Widget>[
        GestureDetector(
            onTap: press,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      blurRadius: 8.0,
                    )
                  ]),
              child: Icon(
                icon,
                color: isFav == false ? Colors.white : const Color(0xffFF5F99),
              ),
            )),
        const SizedBox(
          height: 12.0,
        ),
        Text(label),
      ],
    );
  }

  Widget _button(String label, IconData icon, Color color, VoidCallback press) {
    return Column(
      children: <Widget>[
        GestureDetector(
            onTap: press,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      blurRadius: 8.0,
                    )
                  ]),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            )),
        const SizedBox(
          height: 12.0,
        ),
        Text(label),
      ],
    );
  }

  Widget _body(Food recipe) {
    getImage(recipe);
    return FanCarouselImageSlider(
      imagesLink: listBanners,
      isAssets: false,
      autoPlay: false,
      indicatorActiveColor: Colors.amber,
      indicatorDeactiveColor: Colors.black,
      sliderHeight: 600,
      imageFitMode: BoxFit.fill,
    );
  }
}

class RecipeSteps extends StatelessWidget {
  final List<dynamic> steps;
  const RecipeSteps({super.key, this.steps = const []});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: steps.length,
      padding: const EdgeInsets.all(0.0),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text('${index + 1}',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            title: Text(steps[index],
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)));
      },
    );
  }
}

class IngredientsWidget extends StatelessWidget {
  final Food? dataing;
  const IngredientsWidget({super.key, this.dataing});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: dataing!.ingredient!.length,
              itemBuilder: (context, index) {
                return Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Container(
                            height: 50,
                            color: Colors.red.shade200,
                            child: Center(
                              child: Text("${dataing!.ingredient![index]}",
                                  style: const TextStyle(
                                      fontSize: 16, fontFamily: 'Mitr'),
                                  textAlign: TextAlign.center),
                            ))));
              })),
      Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: dataing!.quantity!.length,
              itemBuilder: (context, index) {
                return Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Container(
                            height: 50,
                            color: Colors.lightGreen,
                            child: Center(
                              child: Text(dataing!.quantity![index],
                                  style: const TextStyle(
                                      fontSize: 16, fontFamily: 'Mitr'),
                                  textAlign: TextAlign.center),
                            ))));
              })),
      Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: dataing!.uom!.length,
              itemBuilder: (context, index) {
                return Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Container(
                            height: 50,
                            color: const Color.fromRGBO(129, 212, 250, 1),
                            child: Center(
                              child: Text("${dataing!.uom![index]}",
                                  style: const TextStyle(
                                      fontSize: 16, fontFamily: 'Mitr'),
                                  textAlign: TextAlign.center),
                            ))));
              }))
    ]);
  }
}

class NutritionWidget extends StatelessWidget {
  final Food? nutrients;
  const NutritionWidget({super.key, this.nutrients});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86,
      width: double.infinity,
      child: Center(
        child: ListView.builder(
          itemCount: nutrients!.nutrients!.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return CircleIndicator(
              percent: nutrients!.nutpercent![index],
              name: nutrients!.nutrients![index],
              weight: nutrients!.nutweight![index],
            );
          },
        ),
      ),
    );
  }
}

class AddEdit extends StatelessWidget {
  const AddEdit({
    Key? key,
    required this.users,
  }) : super(key: key);

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    int totalUser = 0;
    return SizedBox(
      width: double.infinity,
      height: 30,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ...List.generate(
            users.length,
            (index) {
              totalUser++;
              return Positioned(
                left: (22 * index).toDouble(),
                child: buildTravelerFace(index),
              );
            },
          ),
          Positioned(
              left: (22 * totalUser).toDouble(),
              child: InkWell(
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
                onTap: () {},
              ))
        ],
      ),
    );
  }

  ClipOval buildTravelerFace(int index) {
    return ClipOval(
        child: InkWell(
      child: Image.asset(
        users[index].image,
        height: 28,
        width: 28,
        fit: BoxFit.cover,
      ),
      onTap: () {},
    ));
  }
}
