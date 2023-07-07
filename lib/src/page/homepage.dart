import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_towin/src/BottomPage/page_favorite.dart';
import 'package:project_towin/src/BottomPage/page_info.dart';
//import 'package:project_towin/src/BottomPage/page_payment.dart';
//import 'package:project_towin/src/BottomPage/page_wallet.dart';
import 'package:project_towin/src/Feature/profile.dart';
import 'package:project_towin/src/Login/system/login_layout.dart';
import 'package:project_towin/src/Login/Google/login_signin.dart';
import 'package:project_towin/src/Feature/lang_view.dart';
import 'package:project_towin/src/bloc/bloc_signin_google/auth_bloc.dart';
//import 'package:project_towin/src/fitness_app/fitness_app_home_screen.dart';
//import 'package:project_towin/src/page/To_Do_List/home_todolist.dart';
import 'package:project_towin/src/page/page1_northern.dart';
import 'package:project_towin/src/page/page2_northeastern.dart';
import 'package:project_towin/src/page/page3_western.dart';
import 'package:project_towin/src/page/page4_central.dart';
import 'package:project_towin/src/page/page5_eastern.dart';
import 'package:project_towin/src/page/page6_southern.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late MapShapeSource _shapeSource;
  late List<MapModel> _mapData;
  late int _selectedIndex = 29;
  int _selectedPage = 0;

  @override
  void initState() {
    _mapData = _getMapData();
    _shapeSource = MapShapeSource.asset('assets/Thailand.json',
        shapeDataField: 'name',
        dataCount: _mapData.length,
        primaryValueMapper: (int index) => _mapData[index].name,
        shapeColorValueMapper: (int index) => _mapData[index].color);
    super.initState();
  }

  void _onItemTapped(int pageindex) {
    setState(() {
      _selectedPage = pageindex;
    });
    if (pageindex == 0) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => const Home()));
    } else if (pageindex == 1) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const Favorite()));
      /* } else if (pageindex == 2) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => const Wallet()));
    } else if (pageindex == 3) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const Payment()));*/
    } else if (pageindex == 4) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => const Info()));
    }
  }

  final List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: const Icon(Icons.home),
      label: 'btn_bottom1'.tr(),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.favorite),
      label: 'btn_bottom2'.tr(),
    ),
    BottomNavigationBarItem(
        icon: const Icon(Icons.account_balance_wallet),
        label: 'btn_bottom3'.tr()),
    BottomNavigationBarItem(
      icon: const Icon(Icons.payment),
      label: 'btn_bottom4'.tr(),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.info),
      label: 'btn_bottom5'.tr(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: MySearchDelegate());
            },
          ),
          IconButton(
              icon: const Icon(Icons.language),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const LanguageView()));
              })
        ],
        title:
            Text("title_main".tr(), style: const TextStyle(fontFamily: 'Mitr')),
        centerTitle: true,
      ),
      drawer: const NavigationDrawer(),

      //(Icons.menu, color: Colors.white),preferredSize: Size.fromHeight(40),),
      body: Container(
        color: Colors.grey,
        child: Column(children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: SfMaps(
              layers: [
                MapShapeLayer(
                  zoomPanBehavior: MapZoomPanBehavior(
                      enablePanning: true,
                      enablePinching: true,
                      maxZoomLevel: 6),
                  source: _shapeSource,
                  strokeWidth: 2,
                  selectedIndex: _selectedIndex,
                  selectionSettings: const MapSelectionSettings(
                    color: Colors.black,
                  ),
                  onSelectionChanged: (int index) {
                    setState(() {
                      _selectedIndex = (_selectedIndex == index) ? -1 : index;

                      if (index == 0) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด แม่ฮ่องสอน",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นจังหวัดในภาคเหนือของไทย ที่มีความโดดเด่นทางสภาพภูมิประเทศอย่างมาก อีกทั้งยังได้ชื่อว่าเป็น เมืองสามหมอก เนื่องจากมีสภาพภูมิประเทศเต็มไปด้วยภูเขาสูงสลับซับซ้อน สภาพอากาศจึงมีหมอกปกคลุมตลอดเวลา อีกทั้งยังเป็นจังหวัดที่มีความหลากหลายด้านวัฒนธรรม และประชากรจากหลายกลุ่มชาติพันธุ์อีกด้วย",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            });
                      }

                      if (index == 1) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด เชียงใหม่",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นจังหวัดที่เต็มไปด้วยเสน่ห์ของธรรมชาติ และศิลปะวัฒนธรรมที่ตกทอดกันมาเป็นเวลายาวนาน โดยเฉพาะกลิ่นอายของ อารายธรรมล้านนา ที่ยังคงปรากฏให้เห็นทั้งในรูปแบบสถาปัตยกรรมของวัดวาอาราม วัตถุโบราณต่างๆ ที่ยังคงอนุรักษ์เอาไว้ในพิพิธภัณฑ์และโบราณสถานต่างๆ",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 2) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด เชียงราย",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นจังหวัดที่อยู่ทางตอนเหนือสุดของประเทศไทย สภาพภูมิประเทศทั่วไปเป็นป่าไม้และเทือกเขาสูง ทำให้อากาศของจังหวัดเชียงรายในช่วงฤดูร้อนและฤดูหนาวจะมีอุณหภูมิที่แตกต่างกันโดยสิ้นเชิง ในช่วงฤดูหนาวอากาศจะค่อนข้างเย็น อยู่ที่ประมาณ 8 องศา ยิ่งถ้าขึ้นไปบนดอยอากาศก็จะยิ่งต่ำลงไปอีก ส่วนในฤดูร้อนอุณหภูมิอาจขึ้นไปถึงประมาณ 36-37 องศาเซลเซียสเลย",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 3) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ลำปาง",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นพื้นที่ราบลุ่ม ล้อมรอบด้วยหุบเขาจากทุกด้าน ทำให้พื้นที่ของเมืองเป็นแอ่งอยู่ตรงกลางเหมือน แอ่งกระทะ โดยมี แม่น้ำวัง เป็นแม่น้ำสำคัญหล่อเลี้ยงชาวลำปางจากทางเหนือสู่ทางใต้ของจังหวัด ที่น่าสนใจคือมีการค้นพบแหล่งภูเขาไฟอย่าง กลุ่มหินบะซอลต์ ที่เกิดจากลาวาในภูเขาไฟลำปางไหลลงมาอาบทั่วพื้นที่ และก่อตัวอยู่ ณ ที่นั้นเป็นเวลายาวนาน",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 4) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ลำพูน",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นจังหวัดที่มีขนาดเล็กมากที่สุดในภาคเหนือของประเทศไทย แต่มีการพัฒนาเป็นศูนย์กลางแห่งความเจริญทางภาคเหนือตอนบนอยู่ไม่น้อย เนื่องจากตั้งอยู่ในลุ่มแม่น้ำโขง หรือ พื้นที่สี่เหลี่ยมซึ่งเป็นพื้นที่เศรษฐกิจร่วมกับจังหวัดเชียงใหม่ จึงทำให้เหมาะแก่การทำมาค้าขาย การคมนาคม และทำเป็นพื้นที่ทางการเกษตร",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 5) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด น่าน",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นชมวิวสวยๆของทุ่งนาสีเขียว บรรยากาศดีๆ ยังมีเรื่องราวทางวัฒนธรรม ศิลปกรรมล้านนาต่างๆของน่านอีกด้วย",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 6) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด พะเยา",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นที่ตั้งของเมืองภูกามยาว หรือ พะยาว ที่ก่อตั้งขึ้นเมื่อประมาณพุทธศตวรรษที่ 16 โดยกษัตริย์องค์แรกก็คือ พญาจอมธรรม ราชบุตรจากเมืองหิรัญนครเงินยางเชียงแสน และเป็นบรรพบุรุษของกษัตริย์เมืองพะยาวอีกหลายองค์ ไม่ว่าจะเป็น พญาเจือง วีรบุรุษแห่งเผ่าไท-ลาวในพื้นที่ลุ่มแม่น้ำโขง และ พญางำเมือง ที่ได้มีการกระทำสัตย์สาบานเป็นไมตรีกับพญามังรายแห่งนครพิงค์ เชียงใหม่ และพญาร่วงรามคำแหงแห่งสุโขทัย",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 7) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด แพร่",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นประตูเมืองล้านนา ยังมีประวัติศาสตร์ยาวนานไม่ต่างจากจังหวัดอื่นๆ ชวนทุกคนย้อนเวลาสู่เมืองพล (เมืองแพร่เก่า) ไปพร้อมกับประวัติจังหวัดแพร่ เพื่อเจาะลึกถึงความเป็นมารวมถึงสถานที่ท่องเที่ยวน่าสนใจที่ทุกคนไม่ควรพลาด",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 8) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด อุตรดิตถ์",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นเมืองท่าทางเหนือ รวมถึงยังมีตำนานอันลึกลับของเมืองลับแล ดินแดนที่ขึ้นชื่อเรื่องลางสาดหวานๆ หอมๆ และยังเป็นบ้านเกิดของพระยาพิชัยดาบหักอีกด้วย",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 9) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด กาฬสินธุ์",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นจังหวัดที่มีความอุดมสมบูรณ์ จากหลักฐานทางโบราณคดีบ่งบอกว่าเคยเป็นที่อยู่อาศัยของเผ่าละว้า ซึ่งมีความเจริญทางด้านอารยธรรมประมาณ 1,600 ปี พระบาทสมเด็จพระพุทธยอดฟ้าจุฬาโลกมหาราช ต่อมาได้รับพระกรุณาโปรดเกล้า ยกฐานะบ้านแก่งสำโรงขึ้นเป็นเมือง และพระราชทานนามว่าเมืองกาฬสินธุ์ หรือ เมืองน้ำดำซึ่งเป็นเมืองที่สำคัญทางประวัติศาสตร์มาตั้งแต่สมัยโบราณกาล กาฬแปลว่า ดำ สินธุ์แปลว่า น้ำ กาฬสินธุ์จึงแปลว่า น้ำดำ และยังมีแหล่งซากไดโนเสาร์หลายแห่งด้วย โดยเฉพาะอย่างยิ่งในอำเภอสหัสขันธ์ นอกจากนี้ยังมีชื่อเสียงด้านโปงลาง",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 10) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ขอนแก่น",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นศูนย์กลางความเจริญ มีประวัติความเป็นมาที่ยาวนานมากกว่าล้านปี ยังเคยมีที่อยู่ของไดโนเสาร์ เพราะมีการค้นพบรอยเท้าและฟอสซิลไดโนเสาร์พันธุ์กินพืชและพันธุ์กินเนื้อ อายุมากกว่า 4,000 ปี และยังเคยเป็นถิ่นอาศัยของมนุษย์สมัยก่อนประวัติศาสตร์อีกด้วย",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 11) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ชัยภูมิ",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นดินแดนแห่งทุ่งดอกกระเจียวแสนงาม และสายน้ำตกยามหน้าฝน เป็นจังหวัดที่มีพื้นที่ป่ามากที่สุดจังหวัดหนึ่งในภาคอีสาน มีเทือกเขาที่สำคัญได้แก่ ภูพังเหย ภูแลนคา ภูพญาฝ่อ อันเป็นต้นกำเนิดแม่น้ำชี",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 12) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด นครพนม",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นเมืองสวยริมฝั่งโขง อีกทั้งเป็นหนึ่งในอาณาจักรที่มีความรุ่งเรืองอย่างมากในอดีต ยังเป็นจังหวัดที่มีทั้งวัดสวย พระธาตุต่างๆมากมาย รวมไปถึงธรรมชาติวิวสวยๆ",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 13) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด นครราชสีมา",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นจังหวัดที่อยู่ใกล้กรุงเทพ แต่ประวัติความเป็นมาลึกๆ จริงๆ แล้วนั้น เป็นอย่างไร อาจจะไม่มีใครรู้",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 14) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด บึงกาฬ",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นที่เที่ยวธรรมชาติสวยๆ เช่น หินสามวาฬ ภูทอก ถ้ำนาคา บึงโขงหลง พิพิธภัณฑ์ชุมชนมีชีวิต รวมไปถึงน้ำตกสวยๆ อย่าง น้ำตกถ้ำพระ น้ำตกตาดวิมานทิพย์ น้ำตกเจ็ดสี น้ำตกตาดกินรี เป็นต้น",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 15) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด บุรีรัมย์",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "ในสมัยทวารวดี โบราณสถานสำคัญแต่ละแห่งก็ล้วนแต่ทำให้เราจินตนาการได้ถึงความยิ่งใหญ่ของที่นี่ในสมัยก่อน ถึงปัจจุบันจังหวัดนี้ก็ยังเป็นที่ตั้งสำคัญของศูนย์กีฬาขนาดใหญ่มากมาย",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 16) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด มหาสารคาม",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นเมืองแหล่งโบราณคดีที่สำคัญและยาวนานมาหลายร้อยปี เพราะได้พบหลักฐานทางโบราณคดีที่ได้รับอิทธิพลทางพุทธศาสนา ตั้งแต่สมัยคุปตะตอนปลายและปาละวะของอินเดียผ่านเมืองพุกามมาในรูปแบบของศิลปะสมัยทวาราวดี",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 17) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด มุกดาหาร",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นเส้นกั้นพรมแดน และมีความโดดเด่นในด้านชนเผ่าพื้นเมืองต่าง ๆ ที่มีถึง 8 เผ่าได้แก่ เผ่าไทยอีสาน ภูไท ไทยข่า กระโซ่ ไทยย้อ ไทยแสก ไทยกะเลิง และไทยกุลา และยังมีแหล่งท่องเที่ยวทางธรรมชาติที่สวยงาม",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                      if (index == 18) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ยโสธร",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นดินแดนอันอุดมสมบูรณ์ริมฝั่งแม่น้ำชี ได้ชื่อว่าเมืองบั้งไฟ เป็นดินแดนที่มีอดีตอันล้ำค่าและยาวนานกว่า 200 ปี",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 19) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ร้อยเอ็ด",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นเมืองที่มีความเจริญรุ่งเรืองมาแต่ยุคก่อนประวัติศาสตร์ โดยปรากฏชื่อในตำนานอุรังคธาตุว่า สาเกตนคร หรือ เมืองร้อยเอ็ดประตู อันเนื่องมาจากเป็นเมืองที่มีความเจริญรุ่งเรื่องโดยที่มีเมืองขึ้นจำนวนมาก",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 20) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด เลย",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "มีสภาพภูมิประเทศที่งดงาม อากาศหนาวเย็น เป็นแหล่งเพาะปลูกไม้ดอกไม้ประดับที่สำคัญแห่งหนึ่งของประเทศ และยังเป็นจังหวัดท่องเที่ยวที่สำคัญอีกด้วย",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 21) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด สกลนคร",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นเมืองเก่าแก่ที่มีความสำคัญและหลากหลายในด้านต่างๆ โดยเฉพาะทางด้านสิ่งแวดล้อมทางธรรมชาติ ประวัติศาสตร์ สังคม การเมือง ศาสนา และวัฒนธรรมทั้งในระดับชาติและระดับท้องถิ่น และเป็นจังหวัดศูนย์กลางในการพัฒนาทรัพยากรมนุษย์และศูนย์กลางทางการศึกษา",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 22) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด สุรินทร์",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นจังหวัดที่มีประวัติศาสตร์อันยาวนานมากจังหวัดหนึ่ง โดยสันนิษฐานว่าถูกสร้างขึ้นมาเมื่อประมาณ 2,000 ปีมาแล้ว ในสมัยที่พวกขอมมามีอำนาจเหนือพื้นที่แห่งนี้ เมื่อขอมเสื่อมอำนาจลง เมืองสุรินทร์ได้ถูกทิ้งร้างจนเกิดกลายเป็นดงขึ้นมา และเป็นเมืองที่มีช้างมากมายมายมาแต่โบราณ ในสมัยก่อนผู้คนจะไปจับช้างมาเลี้ยงเสมอๆ",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 23) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ศรีสะเกษ",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นเมืองโบราณตั้งแต่สมัยขอม จะเห็นได้จากโบราณสถานสมัยขอมที่ยังปรากฏอยู่ แต่ต่อมาขอมได้เสื่อมอำนาจลงในปลายสมัยกรุงศรีอยุธยาชาวไทยพื้นเมืองที่เรียกตัวเองว่า กวย หรือ กูย ได้อพยพข้ามลำน้ำโขงมาสู่ฝั่งขวา ประมาณปี พ.ศ. ๒๒๕๖ และได้แยกย้ายกันออกไป ๖ กลุ่ม กลุ่มที่มีตากะจะ และเชียงขันได้มาตั้งถิ่นฐานที่บ้านโคกลำดวน",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 24) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด หนองคาย",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นจังหวัดชายแดนซึ่งมีพื้นที่ส่วนใหญ่ติดฝั่งแม่น้ำโขง ตรงข้ามกับประเทศลาว มีพื้นที่แคบแต่ยาว และมีชื่อเสียงด้านการท่องเที่ยว โดยเฉพาะการชมบั้งไฟพญานาคในวันออกพรรษา",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 25) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด หนองบัวลำภู",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "มีการอยู่อาศัยของมนุษย์มานานนับพันปี ตั้งแต่สมัยก่อนประวัติศาสตร์ เริ่มจากการดำรงชีวิตแบบเร่ร่อน มาเป็นตั้งชุมชนอยู่ตามที่เนินสูง ตามถ้ำหรือริมฝั่งน้ำแสวงหาอาหารด้วยการจับปลา ล่าสัตว์และหาพืชผักผลไม้ที่มีอยู่ตามธรรมชาติ มาจนถึงการดำรงชีวิตในสังคมกสิกรรมจึงเริ่มอยู่รวมกันเป็นชุมชนมีการเพาะปลูกเสี้ยงสัตว์ ทำเครื่องประดับ และหล่อโลหะแบบต่างๆ",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 26) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด อุดรธานี",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นที่เที่ยวยอดฮิต มีทั้งธรรมชาติสวย มรดกโลก และ วัดสวยๆมากมาย เช่น ทะเลบัวแดง คำชะโนด ทุ่งดอกไม้ บ้านห้วยสำราญ พิพิธภัณฑสถานแห่งชาติ บ้านเชียง อุทยานประวัติศาสตร์ภูพระบาท วัดป่าภูก้อน วัดสันติวนาราม เป็นต้น",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 27) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด อุบลราชธานี",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นเมืองท่องเที่ยวริมฝั่งโขงที่เต็มไปด้วยแหล่งท่องเที่ยวธรรมชาติสุด Unseen และ วัดสวยๆ แต่ความจริงแล้วที่นี่เต็มไปด้วยเรื่องราวประวัติศาสตร์ และวัฒนธรรมที่น่าสนใจ",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 28) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด อำนาจเจริญ",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "มีประวัติศาสตร์มาอย่างยาวนานจากการค้นพบแหล่งชุมชนโบราณ โบราณสถาน และโบราณวัตถุตามที่กรมศิลปากรค้นพบและสันนิษฐานไว้ตามหลักฐานทางโบราณคดี ยังเจอใบเสมาอายุราว 1,000 ปี และได้ตั้งเป็นเมืองมานานหลายร้อยปี",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 29) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด กรุงเทพมหานคร",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นเมืองใหญ่ที่มีแม่น้ำเจ้าพระยา ไหลผ่านกลางใจเมือง เต็มไปด้วยวัดวาอารามที่สวยงาม ย่านธุรกิจที่คึกคัก และเป็นเมืองหลวงของประเทศไทย ทำให้ปัจจุบันกรุงเทพฯเป็นศูนย์กลางในทุกๆด้านของไทย",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 30) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด กำแพงเพชร",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นเมืองแห่งมรดกโลกและธรรมชาติที่สวยงาม เต็มไปด้วยร่องรอยของเรื่องราวในอดีตที่สะท้อนให้เห็นถึงศิลปะวัฒนธรรมที่สืบทอดมาจนถึงปัจจุบัน",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 31) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ชัยนาท",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นเมืองทางผ่านเล็กๆ แต่ก็มีความเป็นมาตั้งแต่ในสมัยสุโขทัย",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 32) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด นครนายก",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นที่เที่ยวใกล้กรุงเทพฯ ที่เต็มไปด้วยที่เที่ยวธรรมชาติมากมาย ใช้เวลาเดินทางเพียงแค่ชั่วโมงเดียวจากกรุงเทพฯ ก็ได้สูดอากาศดีๆ ที่รายล้อมไปด้วยต้นไม้สีเขียว",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 33) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด นครปฐม",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "มีบรรยากาศของความเป็นธรรมชาติ ทำให้มีคาเฟ่ในสวน ยังเป็นที่ตั้งของพระปฐมเจดีย์ เจดีย์ที่ใหญ่ที่สุดในประเทศไทย ซึ่งเป็นศูนย์รวมจิตใจของพุทธศาสนิกชนทั่วประเทศ ทำให้เชื่อได้ว่าที่นี่เป็นเมืองเก่าแก่มีประวัติยาวนาน",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 34) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด นครสวรรค์",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นที่รู้จักในชื่อของเมืองปากน้ำโพ จังหวัดในภาคกลาง ที่มักจะเป็นแค่ทางผ่านไปเหนือเท่านั้น",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 35) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด นนทบุรี",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นจังหวัดที่ตั้งอยู่ติดกับกรุงเทพฯ ริมแม่น้ำเจ้าพระยา บรรยากาศดี จึงเป็นที่เที่ยวใกล้กรุงเทพ แบบวันเดียวจบ ที่คนกรุงนิยมไปเที่ยวกันมาก นอกเหนือจากนั้นยังมีเรื่องราวประวัติจังหวัดนนทบุรี ที่ยาวนานกว่า 400 ปี ตั้งแต่สมัยกรุงศรีอยุธยาอีกด้วย",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 36) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ปทุมธานี",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "มีประวัติความเป็นมาไม่น้อยกว่า 300 ปีมาแล้ว เริ่มตั้งแต่ในสมัยของสมเด็จพระนารายณ์มหาราช เมื่อปี พ.ศ. 2202 ที่ มังนันทมิตรได้กวาดต้อนครอบครัวมอญ เมืองเมาะตะมะ ให้อพยพหนีภัยจากศึกพม่า เข้ามาพึ่งพระบรมโพธิสมภารสมเด็จพระเจ้าอยู่หัวฯ ซึ่งพระนายรายณ์ ก็ได้ให้ครอบครัวมอญไปตั้งบ้านเรือนอยู่ที่บ้านสามโคก",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 37) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด พระนครศรีอยุธยา",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นอดีตราชธานีของไทยมีหลักฐานของการเป็นเมืองในลุ่มแม่น้ำเจ้าพระยา ตั้งแต่ประมาณพุทธศตวรรษที่ 16 - 18 โดยมีร่องรอยของที่ตั้งเมือง โบราณสถาน โบราณวัตถุ และเรื่องราวเหตุการณ์ในลักษณะ ตำนานพงศาวดาร ไปจนถึงหลักศิลาจารึก ซึ่งถือว่าเป็นหลักฐานร่วมสมัยที่ใกล้เคียงเหตุการณ์มากที่สุด",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 38) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด พิจิตร",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "มีอีกชื่อว่า เมืองชาละวัน ที่เต็มไปด้วยผู้คนน่ารัก และยังมีวิถีชีวิตแบบเรียบง่ายดั้งเดิม รวมถึงยังเป็นจังหวัดเก่าแก่ เต็มไปด้วยประวัติศาสตร์มากมายอีกด้วย",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 39) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด พิษณุโลก",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "มีอีกชื่อว่า เมืองสองแคว เพราะตั้งอยู่ระหว่างแม่น้ำ 2 สาย นั่นก็คือ แม่น้ำน่าน และ แม่น้ำแควน้อย",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 40) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด เพชรบูรณ์",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นที่เที่ยวชมทะเลหมอก และขุนเขา สวยอันดับต้นๆของเมืองไทย ยังมีอุทยานประวัติศาสตร์ศรีเทพอยู่ภายในจังหวัด",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 41) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ลพบุรี",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "ต้องนึกถึงแก๊งฝูงลิงที่วิ่งซนไปทั่วเมือง ยังเป็นเมืองที่เต็มไปด้วยร่องรอยแห่งประวัติศาสตร์ ที่มีความสำคัญไม่แพ้ กรุงเทพมหานคร หรือ พระนครศรีอยุธยาเลย มีที่เที่ยวชมโบราณสถานและธรรมชาติที่สวยงาม",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 42) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด สมุทรปราการ",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "มีอีกชื่อว่า เมืองปากน้ำ ยังมีแหล่งท่องเที่ยวมากมาย ทั้งที่เที่ยวธรรมชาติ วัดสวยๆ ตลาดน้ำ พิพิธภัณฑ์ต่างๆ และยังมีประเพณีที่เป็นเอกลักษณ์อย่าง รับบัว อันโด่งดัง",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 43) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด สมุทรสงคราม",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "มีอีกชื่อว่า  เมืองแม่กลอง ดินแดนหอยหลอด และปลาทูแสนอร่อย ที่เที่ยวใกล้กรุงเทพฯอีกแห่งที่พลาดไม่ได้ โดยเฉพาะตลาดน้ำอัมพวา ตลาดน้ำชื่อดังของไทยที่คงเอกลักษณ์วิถีชีวิตริมน้ำของคนไทยจนนักท่องเที่ยวรู้จักไปทั่วโลก",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 44) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด สมุทรสาคร",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "ริมฝั่งอ่าวไทย มีเวลาน้อยก็เที่ยวได้ ยังมีที่เที่ยวสวยๆมากมาย เรื่องของกินก็ไม่แพ้จังหวัดต่างๆ",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 45) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด สิงห์บุรี",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "ในฐานะจังหวัดที่มีชื่อเสียงในเรื่องของ วัดสวย เก่าแก่ เคยเป็นเมืองที่มีความสำคัญต่อเหตุการณ์บ้านเมืองในประวัติศาสตร์ไทยเป็นอย่างมาก",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 46) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด สุโขทัย",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "มีมาอย่างยาวนานกว่าร้อยๆปีมาแล้ว เป็นหนึ่งจังหวัดที่มีที่เที่ยวหลากหลายมาก และยังเป็นเมืองมรดกโลกอีกด้วย มีทั้งโบราณสถาน ศิลปกรรมต่างๆ ที่เป็นเอกลักษณ์ รวมไปถึงความสวยงามของธรรมชาติและชุมชนที่น่ารัก",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 47) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด สุพรรณบุรี",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "ผู้คนน่ารักเป็นกันเอง และมีสำเนียงเหน่อๆ ที่เป็นเอกลักษณ์ ใครฟังก็รู้เลยว่ามาจากสุพรรณนี่เอง มีครบทุกอย่าง ไม่ว่าจะเป็นภูเขาสวยๆ ตลาดชื่อดัง วัดสวย หรือแม้กระทั่งสถานที่แห่งประวัติศาสตร์",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 48) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด สระบุรี",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "มีที่เที่ยวและความสวยงามมากมายให้เราได้ไปค้นหากัน รอบล้อมด้วยธรรมชาติ สุดชิล อากาศดี วิวสวย ที่สำคัญเที่ยวได้ทั้งปี มีทั้ง น้ำตก วัดสวย ทุ่งดอกไม้",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 49) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด อ่างทอง",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "ไหว้พระ 9 วัด เพราะเป็นจังหวัดเก่าแก่ที่มี วัดสวย วัดเก่าแก่ และโด่งดัง อีกทั้งยังเป็นเมืองที่สงบเงียบอีกด้วย",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 50) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด อุทัยธานี",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "มีที่เที่ยวธรรมชาติ วัดสวยๆ และวิถีชีวิตของคนริมฝั่งแม่น้ำสะแกกรัง ที่มีมายาวนานกว่าพันปี",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 51) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด จันทบุรี",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "หนึ่งในเมืองเก่าแก่ของไทยที่เต็มไปด้วยความสำคัญทางประวัติศาสตร์ มีอายุไม่ต่ำกว่า 1,000 ปี ในช่วงเดียวกันกับอาณาจักรขอมเลยทีเดียว ไล่มาจนถึงสมัยกรุงศรีอยุธยาถึงกลายมาเป็นหนึ่งในอาณาจักรไทย",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 52) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ฉะเชิงเทรา",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "มีที่เที่ยวเชิงเกษตร และที่เที่ยวเชิงวัฒนธรรมอยู่หลายแห่งที่น่าสนใจ",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 53) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ชลบุรี",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "ใครก็นึกถึง บางแสน พัทยา เพราะจากการเดินทางแค่ 1-2 ชั่วโมงจากกรุงเทพฯ เราก็สามารถมาเที่ยวทะเล รับลม สูดอากาศดีๆ กันได้แล้ว",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 54) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ตราด",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เกาะช้าง เกาะหมาก เกาะกูด ที่เที่ยวสุดฮิตของจังหวัดตราด ที่เราต้องไปชิลในทุกหน้าร้อน นอกจากนี้ยังเป็นเหมือนอัญมณีของอ่าวไทยที่เต็มไปด้วยสัตว์น้ำ และปะการังมากมาย รวมถึงที่เที่ยวอื่นๆอีกมากมาย",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 55) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ปราจีนบุรี",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "มีทั้งที่เที่ยวธรรมชาติ และ โบราณสถาน อีกทั้งมีพื้นที่ป่าที่ใหญี่สุดในภาคตะวันออกอีกด้วย",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 56) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ระยอง",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นที่มีชื่อเสียงว่าอุดมไปด้วยสวนผลไม้เที่ยว และที่เที่ยวธรรมชาติสวยๆ ที่ไปได้ทั้งปี เที่ยวเช้าไปเย็นกลับ หรือจะนอนพักค้างคืนริมทะเลก็ชิลดี",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 57) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด สระแก้ว",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "อยู่สุดเส้นทางบูรพา และยังอยู่ติดกับประเทศเพื่อนบ้านอย่าง กัมพูชา อีกด้วย ถ้าพูดถึงที่เที่ยวดัง ต้องยกให้ ตลาดโรงเกลือ",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 58) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด กาญจนบุรี",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "มีที่เที่ยวธรรมชาติ ที่สวยงาม มีวัฒนธรรม ประเพณี ซึ่งเป็นเอกลักษณ์ รวมถึงยังเป็นจังหวัดที่เต็มไปด้วยเรื่องราวประวัติศาสตร์ที่สำคัญของโลก โดยเฉพาะในช่วงสงครามโลกครั้งที่ 2",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 59) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ตาก",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นเมืองแห่งพระเจ้าตากที่มีแหล่งท่องเที่ยวธรรมชาติสวยงามมากมาย ไม่ว่าจะเป็นน้ำตกดังๆ หรือแม้ดอยสวยๆ หนึ่งในที่เที่ยวยอดฮิตของช่วงหน้าฝนและหน้าหนาว",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 60) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ประจวบคีรีขันธ์",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นแหล่งท่องเที่ยวอันหลากหลาย แถมยังมีธรรมชาติครบเครื่อง เหมาะแก่การไปพักตากอากาศสักคืนสองคืนสุดๆ",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 61) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด เพชรบุรี",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นจังหวัดที่มีชื่อเสียงในเรื่องของ หาดสวย ศิลปะวัฒนธรรมที่งดงาม และอาหารเลิศรส",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 62) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ราชบุรี",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "มีประวัติความเป็นมายาวนานมากแห่งหนึ่ง หลักฐานที่ขุดพบจากแหล่งโบราณคดีต่างๆ บ่งบอกได้ว่า ดินแดนลุ่มน้ำแม่กลองแห่งนี้เป็นถิ่นที่อยู่อาศัยของมนุษย์ตั้งแต่สมัย ยุคหินกลาง และเริ่มพัฒนาจนเกิดเป็นอารายธรรมใน สมัยทวาราวดี และเริ่มเจริญรุ่งเรืองขึ้นตั้งแต่ปี พ.ศ. 218 อีกทั้งเป็นแหล่งทำมาค้าขายกับชาวต่างชาติ",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 63) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด กระบี่",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "จังหวัดที่มีทะเลสวยๆ เกาะดังๆ ของ ภาคใต้ ไฮไลท์ของกระบี่คือ เกาะน้อยใหญ่สวยงามกว่าร้อยเกาะ ที่ใครมาก็ต้องตกหลุมรัก",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 64) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ชุมพร",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "มีฐานะเป็นเมืองสิบสองนักษัตรของนครศรีธรรมราช เป็นเมืองหน้าด่านฝ่ายเหนือเพราะอยู่ทางตอนบนของภาคใต้",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 65) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ตรัง",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เมืองทะเลแดนใต้ เงียบสงบ มีน้ำใสๆ ให้นักท่องเที่ยวอย่างเราๆ ไปเยือน",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 66) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด นครศรีธรรมราช",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เมืองแหล่งธรรมชาติบริสุทธิ์ และใหญ่เป็นอันดับ 2 ของ ภาคใต้",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 67) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด นราธิวาส",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นหนึ่งในจังหวัดชายแดนใต้สุดของประเทศไทย มีอาณาเขตติดต่อกับประเทศมาเลเซีย ตั้งอยู่บนชายฝั่งทะเลตะวันออกของแหลมมลายู",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 68) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ปัตตานี",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นที่แวะพักจอดเรือ เพื่อแลกเปลี่ยนซื้อ-ขายสินค้าระหว่างพ่อค้าชาวอินเดียทางตะวันตกกับพ่อค้าชาวจีนทางตะวันออกและชนพื้นเมืองบน แผ่นดินและหมูเกาะใกล้เคียงต่างๆ",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 69) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด พังงา",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "จังหวัดที่เต็มไปด้วย ที่เที่ยวสวย ธรรมชาติอันสมบูรณ์ โดยเฉพาะที่เที่ยวทางทะเล",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 70) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด พัทลุง",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "ตั้งแต่สมัยก่อนประวัติศาสตร์ ดังปรากฏหลักฐานจากการค้นพบขวานหินขัดในท้องที่ทั่วไปหลายอำเภอในสมัยศรีวิชัย พุทธศตวรรษที่ 13-14 บริเวณเมืองพัทลุงเป็นแหล่งชุมชนที่ได้รับวัฒนธรรมอินเดียในด้านพระพุทธศาสนาลัทธิมหายาน มีหลักฐานค้นพบ เช่น พระพิมพ์ดินดิบจำนวนมากเป็นรูปพระโพธิสัตว์ รูปเทวดาโดยค้นพบบริเวณถ้ำคูหาสวรรค์ และถ้ำเขาอกทะลุ",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 71) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ภูเก็ต",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "จังหวัดยอดฮิตทางภาคใต้ ที่มีที่เที่ยวมากมายทั้ง ชายหาด วัฒนธรรมประเพณีแบบผสมผสานทั้งไทย จีน มลายู อาหารการกินที่หลากหลาย",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 72) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ระนอง",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "มีที่เที่ยวหลากหลายไม่ว่าจะทะเล น้ำตก ป่าเขา รวมไปถึงแหล่งแช่น้ำร้อนชื่อดังที่มีความดีงามไม่ต่างจากได้ไปแช่ออนเซ็นที่ญี่ปุ่นเลย แถมบรรยากาศของเมืองยังมีฝนตกชุกตลอดทั้งปี สมชื่อฉายาเมืองฝนแปด แดดสี่",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 73) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด สตูล",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "สตูล มาจากคำภาษามลายูเกอดะฮ์ว่า สะตุล แปลว่ากระท้อน",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 74) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด สงขลา",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "จังหวัดที่คนส่วนใหญ่จะนิยมเดินทางไปแค่เพียง หาดใหญ่เท่านั้น แต่จริงๆที่นี่มีเสน่ห์และความเงียบสงบเรียบง่าย",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 75) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด สุราษฎร์ธานี",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "เป็นจังหวัดที่มีพื้นที่มากที่สุดของภาคใต้ ยังมีความยิ่งใหญ่และรุ่งเรืองอย่างมากในอดีต ที่ไม่ได้มีดีเพียงแค่ทะเลใส หาดสวยเท่านั้น แต่ยังมีภูเขา ป่าไม้ เขื่อน รวมถึงวัดวาอารมอีกด้วย",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }

                      if (index == 76) {
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: const Text(
                            "จังหวัด ยะลา",
                            style: TextStyle(
                                color: Colors.pink, fontFamily: 'Mitr'),
                          ),
                          content: const Text(
                              "มีอาณาเขตทางใต้ติดกับประเทศมาเลเซีย เป็นจังหวัดเดียวในภาคใต้ที่ไม่ติดทะเล อีกทั้งคำว่า ยะลา มาจากภาษาพื้นเมืองเดิมว่า ยะลอ ซึ่งแปลว่า แห",
                              style: TextStyle(fontFamily: 'Mitr')),
                          backgroundColor: Colors.grey.shade400,
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                    });
                  },
                ),
              ],
            ),
          )),
          GestureDetector(
            child: buttonSC(Colors.pink.shade50, "btn_1".tr()),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Page1()));
            },
          ),
          GestureDetector(
            child: buttonSC(Colors.yellow.shade100, "btn_2".tr()),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Page2()));
            },
          ),
          GestureDetector(
            child: buttonSC(Colors.green.shade300, "btn_3".tr()),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Page3()));
            },
          ),
          GestureDetector(
            child: buttonSC(Colors.red.shade100, "btn_4".tr()),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Page4()));
            },
          ),
          GestureDetector(
            child: buttonSC(Colors.green.shade100, "btn_5".tr()),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Page5()));
            },
          ),
          GestureDetector(
            child: buttonSC(Colors.purple.shade100, "btn_6".tr()),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Page6()));
            },
          ),
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _menuBar,
        currentIndex: _selectedPage,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  static List<MapModel> _getMapData() {
    return <MapModel>[
      //ภาคเหนือ
      MapModel('Mae Hong Son', Colors.pink.withAlpha(100)),
      MapModel('Chiang Mai', Colors.pink.withAlpha(100)),
      MapModel('Chiang Rai', Colors.pink.withAlpha(100)),
      MapModel('Lampang', Colors.pink.withAlpha(100)),
      MapModel('Lamphun', Colors.pink.withAlpha(100)),
      MapModel('Nan', Colors.pink.withAlpha(100)),
      MapModel('Phayao', Colors.pink.withAlpha(100)),
      MapModel('Phrae', Colors.pink.withAlpha(100)),
      MapModel('Uttaradit', Colors.pink.withAlpha(100)),
      //ภาคตะวันออกเฉียงเหนือ
      MapModel('Kalasin', Colors.yellow.shade200),
      MapModel('Khon Kaen', Colors.yellow.shade200),
      MapModel('Chaiyaphum', Colors.yellow.shade200),
      MapModel('Nakhon Phanom', Colors.yellow.shade200),
      MapModel('Nakhon Ratchasima', Colors.yellow.shade200),
      MapModel('Bueng Kan', Colors.yellow.shade200),
      MapModel('Buriram', Colors.yellow.shade200),
      MapModel('Maha Sarakham', Colors.yellow.shade200),
      MapModel('Mukdahan', Colors.yellow.shade200),
      MapModel('Yasothon', Colors.yellow.shade200),
      MapModel('Roi Et', Colors.yellow.shade200),
      MapModel('Loei', Colors.yellow.shade200),
      MapModel('Sakon Nakhon', Colors.yellow.shade200),
      MapModel('Surin', Colors.yellow.shade200),
      MapModel('Sisaket', Colors.yellow.shade200),
      MapModel('Nong Khai', Colors.yellow.shade200),
      MapModel('Nong Bua Lamphu', Colors.yellow.shade200),
      MapModel('Udon Thani', Colors.yellow.shade200),
      MapModel('Ubon Ratchathani', Colors.yellow.shade200),
      MapModel('Amnat Charoen', Colors.yellow.shade200),
      //ภาคกลาง
      MapModel('Bangkok', Colors.red.shade200),
      MapModel('Kamphaeng Phet', Colors.red.shade200),
      MapModel('Chai Nat', Colors.red.shade200),
      MapModel('Nakhon Nayok', Colors.red.shade200),
      MapModel('Nakhon Pathom', Colors.red.shade200),
      MapModel('Nakhon Sawan', Colors.red.shade200),
      MapModel('Nonthaburi', Colors.red.shade200),
      MapModel('Pathum Thani', Colors.red.shade200),
      MapModel('Phra Nakhon Si Ayutthaya', Colors.red.shade200),
      MapModel('Phichit', Colors.red.shade200),
      MapModel('Phitsanulok', Colors.red.shade200),
      MapModel('Phetchabun', Colors.red.shade200),
      MapModel('Lopburi', Colors.red.shade200),
      MapModel('Samut Prakan', Colors.red.shade200),
      MapModel('Samut Songkhram', Colors.red.shade200),
      MapModel('Samut Sakhon', Colors.red.shade200),
      MapModel('Sing Buri', Colors.red.shade200),
      MapModel('Sukhothai', Colors.red.shade200),
      MapModel('Suphan Buri', Colors.red.shade200),
      MapModel('Saraburi', Colors.red.shade200),
      MapModel('Ang Thong', Colors.red.shade200),
      MapModel('Uthai Thani', Colors.red.shade200),
      //ภาคตะวันออก
      MapModel('Chanthaburi', Colors.lightGreen.shade200),
      MapModel('Chachoengsao', Colors.lightGreen.shade200),
      MapModel('Chonburi', Colors.lightGreen.shade200),
      MapModel('Trat', Colors.lightGreen.shade200),
      MapModel('Prachinburi', Colors.lightGreen.shade200),
      MapModel('Rayong', Colors.lightGreen.shade200),
      MapModel('Sa Kaeo', Colors.lightGreen.shade200),
      //ภาคตะวันตก
      MapModel('Kanchanaburi', Colors.green),
      MapModel('Tak', Colors.green),
      MapModel('Prachuap Khiri Khan', Colors.green),
      MapModel('Phetchaburi', Colors.green),
      MapModel('Ratchaburi', Colors.green),
      //ภาคใต้
      MapModel('Krabi', Colors.purple.shade100),
      MapModel('Chumphon', Colors.purple.shade100),
      MapModel('Trang', Colors.purple.shade100),
      MapModel('Nakhon Si Thammarat', Colors.purple.shade100),
      MapModel('Narathiwat', Colors.purple.shade100),
      MapModel('Pattani', Colors.purple.shade100),
      MapModel('Phang Nga', Colors.purple.shade100),
      MapModel('Phatthalung', Colors.purple.shade100),
      MapModel('Phuket', Colors.purple.shade100),
      MapModel('Ranong', Colors.purple.shade100),
      MapModel('Satun', Colors.purple.shade100),
      MapModel('Songkhla', Colors.purple.shade100),
      MapModel('Surat Thani', Colors.purple.shade100),
      MapModel('Yala', Colors.purple.shade100),
    ];
  }
}

class MySearchDelegate extends SearchDelegate {
  List<String> searchResults = ['A', 'B'];
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: (() {
          close(context, null);
        }),
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            })
      ];

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(query, style: const TextStyle(fontSize: 50)),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searchResults) {
      final result = searchResults.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];

          return ListTile(
            title: Text(suggestion),
            onTap: (() {
              query = suggestion;

              showResults(context);
            }),
          );
        });
  }
}

Widget buttonSC(Color color, String text) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), color: color),
      width: double.infinity,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontFamily: 'Mitr'),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

final user = FirebaseAuth.instance.currentUser!;

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: Colors.amber.shade200,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        )),
      );
}

Widget buildHeader(BuildContext context) => Material(
    color: Colors.amber,
    child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const Profile()));
        },
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(children: [
            CircleAvatar(
              radius: 52,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
            const SizedBox(height: 12),
            Text(user.displayName!,
                style: const TextStyle(fontSize: 16, fontFamily: 'Mitr')),
            Text(user.email!,
                style: const TextStyle(fontSize: 16, fontFamily: 'Mitr')),
            const SizedBox(height: 12),
          ]),
        )));

Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('หน้าหลัก', style: TextStyle(fontFamily: 'Mitr')),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          /*ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(3),
              child: Image.asset(
                "assets/images/book.png",
                width: 18,
                height: 18,
                color: Colors.grey.shade700,
              ),
            ),
            title:
                const Text('การกินอาหาร', style: TextStyle(fontFamily: 'Mitr')),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const FitnessAppHomeScreen()));
            },
          ),*/
          ListTile(
            leading: const Icon(Icons.today_rounded),
            title: const Text('สิ่งที่ต้องทำ',
                style: TextStyle(fontFamily: 'Mitr')),
            onTap: () {
              //Navigator.of(context).push(MaterialPageRoute(
              //    builder: (BuildContext context) => const EventCalendar()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title:
                const Text('ข้อเสนอแนะ', style: TextStyle(fontFamily: 'Mitr')),
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => const FeedbackScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title:
                const Text('ช่วยเหลือ', style: TextStyle(fontFamily: 'Mitr')),
            onTap: () {
              //Navigator.of(context).push(MaterialPageRoute(
              //   builder: (BuildContext context) => const HelpScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.mail),
            title: const Text('จดหมาย', style: TextStyle(fontFamily: 'Mitr')),
            onTap: () {
              //Navigator.of(context).push(MaterialPageRoute(
              //   builder: (BuildContext context) => const HelpScreen()));
            },
          ),
          const Divider(
            thickness: 2,
            color: Colors.black54,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: TextButton.icon(
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text("ออกจากระบบ",
                    style: TextStyle(fontFamily: 'Mitr', color: Colors.red)),
                onPressed: () {
                  context.read<AuthBloc>().add(SignOutRequested());
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const LoginGoogle()));
                }),
          )
        ],
      ),
    );

class MapModel {
  MapModel(this.name, this.color);
  String name;

  Color color;
}
