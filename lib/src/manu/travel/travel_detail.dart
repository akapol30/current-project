import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_towin/src/Feature/profile.dart';
import 'package:project_towin/src/api/weather_api.dart';

import 'package:project_towin/src/manu/travel/User.dart';

import 'package:project_towin/src/manu/travel/travel_converse.dart';
import 'package:project_towin/src/manu/travel/travel_trip.dart';

import 'package:project_towin/src/modelclass/class_list_food.dart';
import 'package:project_towin/src/modelclass/class_weather.dart';

import 'package:project_towin/src/page/homepage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';

class SlidingUpPanelExampleTravel extends StatelessWidget {
  final Food recipe;
  const SlidingUpPanelExampleTravel({super.key, required this.recipe});
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
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buttonfav("Favorite", Icons.favorite, Colors.blue, () {
                  setState(() {
                    isFav = !isFav;
                  });
                }),
                _button("Map", Icons.gps_fixed, Colors.red, () {
                  showDialog(
                    context: context,
                    builder: (_) => const MapOverlay(),
                  );
                }),
                _button("Event", Icons.event, Colors.purple, () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const TripGroupNorth()));
                }),
                _button("Discuss", Icons.comment, Colors.orange, () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const TravelConverseNorth()));
                }),
                _button("share", Icons.share, Colors.green, () {}),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            Container(
              color: Colors.cyan.shade200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("เวลา เปิด-ปิด:",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Mitr')),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text("จันทร์ – อาทิตย์ เวลา 8:00 -16:00 น.",
                        style: TextStyle(fontSize: 13, fontFamily: 'Mitr')),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.cyan.shade200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("วันหยุด:",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Mitr')),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("ไม่มี",
                        style: TextStyle(fontSize: 13, fontFamily: 'Mitr')),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
                color: Colors.green.shade200,
                child: Row(children: const [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("ช่วงเวลาที่เหมาะสม:",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Mitr')),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("กันยายน ถึง พฤษจิกายน",
                      style: TextStyle(fontSize: 13, fontFamily: 'Mitr'))
                ])),
            Container(
                color: Colors.yellow.shade200,
                child: const Text("ค่าธรรมเนียมเข้าสถานที่",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mitr'))),
            Container(
                height: 40,
                color: Colors.yellow.shade200,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: SizedBox(
                              height: 40,
                              child: Text('ค่าเข้าเด็ก: ฟรี',
                                  style: TextStyle(
                                      fontSize: 13, fontFamily: 'Mitr'),
                                  textAlign: TextAlign.center)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: SizedBox(
                              height: 40,
                              child: Text('ค่าเข้าผู้ใหญ่: ฟรี',
                                  style: TextStyle(
                                      fontSize: 13, fontFamily: 'Mitr'),
                                  textAlign: TextAlign.center)),
                        ),
                      ),
                    ])),
            Container(
                color: Colors.orange.shade200,
                child: const Text("กิจกรรมที่น่าสนใจ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mitr'))),
            Container(
                color: Colors.orange.shade100,
                child: Column(children: const [
                  Text("[0] ชมนาข้าวขั้นบันไดที่ชาวบ้านปลูกเอาไว้ครับ",
                      style: TextStyle(fontSize: 13, fontFamily: 'Mitr')),
                  Text("[1] ชมนาข้าวขั้นบันไดที่ชาวบ้านปลูกเอาไว้ครับ",
                      style: TextStyle(fontSize: 13, fontFamily: 'Mitr')),
                  Text("[0] ชมนาข้าวขั้นบันไดที่ชาวบ้านปลูกเอาไว้ครับ",
                      style: TextStyle(fontSize: 13, fontFamily: 'Mitr'))
                ])),
            Container(
                color: Colors.pink.withAlpha(100),
                child: const Text(" เบอร์โทรติดต่อ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mitr'))),
            Container(
              color: Colors.pink.withAlpha(50),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(" คุณอุ่น โทร. 089-952-0983",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 13, fontFamily: 'Mitr')),
                    Text(" คุณสมศักดิ์ โทร. 081-960-8856",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 13, fontFamily: 'Mitr')),
                  ]),
            ),
            Container(
                color: Colors.purple.withAlpha(100),
                child: const Text(" ร้านอาหารใกล้เคียง",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mitr'))),
            Container(
              color: Colors.purple.withAlpha(50),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("#ร้านอาหาร",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 13, fontFamily: 'Mitr')),
                    SizedBox(
                      width: 10,
                    ),
                    Text("#ร้านข้าว",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 13, fontFamily: 'Mitr')),
                  ]),
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
          ),
        ),
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

class MapOverlay extends StatefulWidget {
  const MapOverlay({super.key});

  @override
  State<StatefulWidget> createState() => MapOverlayState();
}

class MapOverlayState extends State<MapOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);

    controller!.addListener(() {
      setState(() {});
    });

    controller!.forward();
    getLocation();
  }

  LatLng latLngResGPS = const LatLng(18.7990476, 98.9752109);

  //LatLng latLngCutGPS = LatLng(18.7990476, 98.9752109);

  GoogleMapController? mapController;
  Position? _userLocation;
  final List<Marker> _markers = [];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    try {
      _userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      _markers.add(Marker(
          markerId: const MarkerId('Current Location'),
          position: latLngResGPS,
          infoWindow: const InfoWindow(title: 'ตำแหน่งร้าน')));
    } catch (e) {
      _userLocation = null;
    }
    return _userLocation!;
  }

  double lat = 18.7990476;
  double lng = 98.9752109;

  WeatherApi client = WeatherApi();
  Weather? datawt;

  var date = DateTime.now();
  var formatterfull = DateFormat.yMMMEd();

  Future<void> getData() async {
    datawt = await client.getCurrentWeather(lat, lng);

    //print(datawt!.tempmax0);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation!,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                    color: Colors.blue.withAlpha(150),
                    child: Row(children: const [
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text("สภาพอากาศ:",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Mitr')),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("11:50 AM - Wednesday,4 May 2022",
                          style: TextStyle(fontSize: 13, fontFamily: 'Mitr'))
                    ])),
                Container(
                    height: 120,
                    color: Colors.blue.withAlpha(100),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FutureBuilder(
                        future: getData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Row(children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    const Text('Today',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                    if (datawt!.weathericon0 == "01d")
                                      Image.asset(
                                        'assets/Weather/01d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon0 == "02d")
                                      Image.asset(
                                        'assets/Weather/02d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon0 == "03d")
                                      Image.asset(
                                        'assets/Weather/03d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon0 == "04d")
                                      Image.asset(
                                        'assets/Weather/04d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon0 == "09d")
                                      Image.asset(
                                        'assets/Weather/09d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon0 == "10d")
                                      Image.asset(
                                        'assets/Weather/10d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon0 == "11d")
                                      Image.asset(
                                        'assets/Weather/11d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon0 == "13d")
                                      Image.asset(
                                        'assets/Weather/13d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon0 == "50d")
                                      Image.asset(
                                        'assets/Weather/50d.png',
                                        scale: 2,
                                      ),
                                    Text(
                                        '${datawt!.tempmin0}°C | ${datawt!.tempmax0}°C',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                    Text("${datawt!.weatherMain0}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text(
                                        DateFormat('EEEE').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                datawt!.date1! * 1000)),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                    if (datawt!.weathericon1 == "01d")
                                      Image.asset(
                                        'assets/Weather/01d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon1 == "02d")
                                      Image.asset(
                                        'assets/Weather/02d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon1 == "03d")
                                      Image.asset(
                                        'assets/Weather/03d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon1 == "04d")
                                      Image.asset(
                                        'assets/Weather/04d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon1 == "09d")
                                      Image.asset(
                                        'assets/Weather/09d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon1 == "10d")
                                      Image.asset(
                                        'assets/Weather/10d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon1 == "11d")
                                      Image.asset(
                                        'assets/Weather/11d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon1 == "13d")
                                      Image.asset(
                                        'assets/Weather/13d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon1 == "50d")
                                      Image.asset(
                                        'assets/Weather/50d.png',
                                        scale: 2,
                                      ),
                                    Text(
                                        '${datawt!.tempmin1}°C | ${datawt!.tempmax1}°C',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                    Text("${datawt!.weatherMain1}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text(
                                        DateFormat('EEEE').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                datawt!.date2! * 1000)),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                    if (datawt!.weathericon2 == "01d")
                                      Image.asset(
                                        'assets/Weather/01d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon2 == "02d")
                                      Image.asset(
                                        'assets/Weather/02d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon2 == "03d")
                                      Image.asset(
                                        'assets/Weather/03d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon2 == "04d")
                                      Image.asset(
                                        'assets/Weather/04d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon2 == "09d")
                                      Image.asset(
                                        'assets/Weather/09d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon2 == "10d")
                                      Image.asset(
                                        'assets/Weather/10d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon2 == "11d")
                                      Image.asset(
                                        'assets/Weather/11d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon2 == "13d")
                                      Image.asset(
                                        'assets/Weather/13d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon2 == "50d")
                                      Image.asset(
                                        'assets/Weather/50d.png',
                                        scale: 2,
                                      ),
                                    Text(
                                        '${datawt!.tempmin2}°C | ${datawt!.tempmax2}°C',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                    Text("${datawt!.weatherMain2}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text(
                                        DateFormat('EEEE').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                datawt!.date3! * 1000)),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                    if (datawt!.weathericon3 == "01d")
                                      Image.asset(
                                        'assets/Weather/01d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon3 == "02d")
                                      Image.asset(
                                        'assets/Weather/02d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon3 == "03d")
                                      Image.asset(
                                        'assets/Weather/03d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon3 == "04d")
                                      Image.asset(
                                        'assets/Weather/04d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon3 == "09d")
                                      Image.asset(
                                        'assets/Weather/09d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon3 == "10d")
                                      Image.asset(
                                        'assets/Weather/10d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon3 == "11d")
                                      Image.asset(
                                        'assets/Weather/11d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon3 == "13d")
                                      Image.asset(
                                        'assets/Weather/13d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon3 == "50d")
                                      Image.asset(
                                        'assets/Weather/50d.png',
                                        scale: 2,
                                      ),
                                    Text(
                                        '${datawt!.tempmin3}°C | ${datawt!.tempmax3}°C',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                    Text("${datawt!.weatherMain3}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text(
                                        DateFormat('EEEE').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                datawt!.date4! * 1000)),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                    if (datawt!.weathericon4 == "01d")
                                      Image.asset(
                                        'assets/Weather/01d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon4 == "02d")
                                      Image.asset(
                                        'assets/Weather/02d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon4 == "03d")
                                      Image.asset(
                                        'assets/Weather/03d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon4 == "04d")
                                      Image.asset(
                                        'assets/Weather/04d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon4 == "09d")
                                      Image.asset(
                                        'assets/Weather/09d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon4 == "10d")
                                      Image.asset(
                                        'assets/Weather/10d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon4 == "11d")
                                      Image.asset(
                                        'assets/Weather/11d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon4 == "13d")
                                      Image.asset(
                                        'assets/Weather/13d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon4 == "50d")
                                      Image.asset(
                                        'assets/Weather/50d.png',
                                        scale: 2,
                                      ),
                                    Text(
                                        '${datawt!.tempmin4}°C | ${datawt!.tempmax4}°C',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                    Text("${datawt!.weatherMain4}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text(
                                        DateFormat('EEEE').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                datawt!.date5! * 1000)),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                    if (datawt!.weathericon5 == "01d")
                                      Image.asset(
                                        'assets/Weather/01d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon5 == "02d")
                                      Image.asset(
                                        'assets/Weather/02d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon5 == "03d")
                                      Image.asset(
                                        'assets/Weather/03d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon5 == "04d")
                                      Image.asset(
                                        'assets/Weather/04d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon5 == "09d")
                                      Image.asset(
                                        'assets/Weather/09d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon5 == "10d")
                                      Image.asset(
                                        'assets/Weather/10d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon5 == "11d")
                                      Image.asset(
                                        'assets/Weather/11d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon5 == "13d")
                                      Image.asset(
                                        'assets/Weather/13d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon5 == "50d")
                                      Image.asset(
                                        'assets/Weather/50d.png',
                                        scale: 2,
                                      ),
                                    Text(
                                        '${datawt!.tempmin5}°C | ${datawt!.tempmax5}°C',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                    Text("${datawt!.weatherMain5}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text(
                                        DateFormat('EEEE').format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                datawt!.date6! * 1000)),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                    if (datawt!.weathericon6 == "01d")
                                      Image.asset(
                                        'assets/Weather/01d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon6 == "02d")
                                      Image.asset(
                                        'assets/Weather/02d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon6 == "03d")
                                      Image.asset(
                                        'assets/Weather/03d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon6 == "04d")
                                      Image.asset(
                                        'assets/Weather/04d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon6 == "09d")
                                      Image.asset(
                                        'assets/Weather/09d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon6 == "10d")
                                      Image.asset(
                                        'assets/Weather/10d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon6 == "11d")
                                      Image.asset(
                                        'assets/Weather/11d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon6 == "13d")
                                      Image.asset(
                                        'assets/Weather/13d.png',
                                        scale: 2,
                                      ),
                                    if (datawt!.weathericon6 == "50d")
                                      Image.asset(
                                        'assets/Weather/50d.png',
                                        scale: 2,
                                      ),
                                    Text(
                                        '${datawt!.tempmin6}°C | ${datawt!.tempmax6}°C',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                    Text("${datawt!.weatherMain6}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              )
                            ]);
                          }
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [CircularProgressIndicator()]);
                        },
                      ),
                    )),
                FutureBuilder(
                    future: getLocation(),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                            height: 500,
                            child: GoogleMap(
                                mapType: MapType.normal,
                                onMapCreated: _onMapCreated,
                                markers: Set<Marker>.of(_markers),
                                myLocationEnabled: true,
                                scrollGesturesEnabled: true,
                                initialCameraPosition: CameraPosition(
                                    target: latLngResGPS
                                    /*LatLng(
                                              _userLocation!.latitude,
                                              _userLocation!.longitude)*/
                                    ,
                                    zoom: 16)));
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [CircularProgressIndicator()],
                        );
                      }
                    })),
              ]),
            ),
          ),
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
