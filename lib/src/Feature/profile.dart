import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var birthday = DateFormat("dd/MM/yyyy");
  int age = 0, weight = 0, height = 0;
  List radiotravel = [1, 2, 3];
  List travel = ["คนเดียว", "กับเพื่อน", "กับครอบครัว"];
  List radiotravelstyle = [1, 2, 3, 4, 5, 6];
  List travelstyle = [
    "ผจญภัย",
    "สรรหาของอร่อย",
    "เชิงประวัติศาสตร์",
    "บรรยากาศสวยๆ",
    "ช้อปปิ้ง",
    "คอนเสิร์ต"
  ];
  List radiores = [1, 2, 3, 4, 5];
  List restaurant = [
    "อาหารอร่อย",
    "เมนูแนะนำเยอะ",
    "วิวสวย , อากาศดี",
    "ราคาอาหาร",
    "ตามประเภทอาหาร"
  ];
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1940, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        int yearpicked =
            int.parse(DateFormat("yyyy").format(picked).toString());
        int yearselectedDate =
            int.parse(DateFormat("yyyy").format(selectedDate).toString());
        selectedDate = picked;
        age = yearselectedDate - yearpicked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        backgroundColor: Colors.amber.shade100,
        appBar: AppBar(
          title: const Text("แนะนำตัว", style: TextStyle(fontFamily: 'Mitr')),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 12),
              Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 72,
                    backgroundImage: NetworkImage(user.photoURL!),
                  )),
              const SizedBox(height: 12),
              Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: Row(
                    children: [
                      const Icon(Icons.person),
                      const SizedBox(width: 12),
                      Text(user.displayName!,
                          style: const TextStyle(
                              fontSize: 16, fontFamily: 'Mitr')),
                    ],
                  )),
              const SizedBox(height: 12),
              Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: Row(
                    children: [
                      const Icon(Icons.email),
                      const SizedBox(width: 12),
                      Text(user.email!,
                          style: const TextStyle(
                              fontSize: 16, fontFamily: 'Mitr')),
                    ],
                  )),
              const SizedBox(height: 12),
              Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: Row(
                    children: const [
                      Icon(Icons.abc),
                      SizedBox(width: 12),
                      Text("ทั่วไป",
                          style: TextStyle(fontSize: 16, fontFamily: 'Mitr')),
                    ],
                  )),
                    const SizedBox(height: 12),
                   Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      FaIcon(FontAwesomeIcons.award),
                      SizedBox(width: 12),
                      Text("0",
                          style: TextStyle(fontSize: 16, fontFamily: 'Mitr',color: Colors.orange)),
                      SizedBox(width: 12),
                      Icon(Icons.monetization_on),
                      SizedBox(width: 12),
                      Text("0",
                          style: TextStyle(fontSize: 16, fontFamily: 'Mitr',color: Colors.green)),
                      SizedBox(width: 12),
                      ImageIcon( AssetImage("assets/images/service.png")),
                      SizedBox(width: 12),
                      Text("0",
                          style: TextStyle(fontSize: 16, fontFamily: 'Mitr',color: Colors.purple)),
                    ],
                  ),
              const SizedBox(height: 12),
              const Divider(
                indent: 20,
                endIndent: 20,
                thickness: 2,
                color: Colors.black54,
              ),
              const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("ประวัติ",
                          style: TextStyle(fontSize: 20, fontFamily: 'Mitr')))),
              Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(children: [
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text("วันเกิด : ",
                            style:
                                TextStyle(fontSize: 16, fontFamily: 'Mitr'))),
                    const SizedBox(width: 8),
                    Text(birthday.format(selectedDate),
                        style:
                            const TextStyle(fontSize: 16, fontFamily: 'Mitr')),
                    FirebaseAuth.instance.currentUser !=
                            FirebaseAuth.instance.currentUser
                        ? IconButton(
                            icon:
                                const FaIcon(FontAwesomeIcons.pencil, size: 16),
                            onPressed: () {
                              _selectDate(context);
                            })
                        : IconButton(
                            icon:
                                const FaIcon(FontAwesomeIcons.pencil, size: 16),
                            onPressed: () {}),
                    const SizedBox(width: 8),
                    const Text("อายุ : ",
                        style: TextStyle(fontSize: 16, fontFamily: 'Mitr')),
                    const SizedBox(width: 8),
                    Text("$age ปี",
                        style:
                            const TextStyle(fontSize: 16, fontFamily: 'Mitr')),
                  ])),
              Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(children: [
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text("น้ำหนัก : ",
                            style:
                                TextStyle(fontSize: 16, fontFamily: 'Mitr'))),
                    const SizedBox(width: 5),
                    Text("$weight kg.",
                        style:
                            const TextStyle(fontSize: 16, fontFamily: 'Mitr')),
                    FirebaseAuth.instance.currentUser !=
                            FirebaseAuth.instance.currentUser
                        ? IconButton(
                            icon:
                                const FaIcon(FontAwesomeIcons.pencil, size: 16),
                            onPressed: () {
                              Widget agree = TextButton(
                                  child: const Text('ตกลง'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  });
                              Widget cancel = TextButton(
                                  child: const Text('ยกเลิก'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  });
                              AlertDialog alert = AlertDialog(
                                  insetPadding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  title: const Text(
                                    "น้ำหนักเท่าไหร่",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Mitr'),
                                  ),
                                  content: TextFormField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9.]+')),
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: const InputDecoration(
                                        labelText: 'กิโลกรัม',
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (String value) async {
                                        setState(() {
                                          weight = int.parse(value);
                                        });
                                      }),
                                  actions: <Widget>[agree, cancel]);

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  });
                            })
                        : IconButton(
                            icon:
                                const FaIcon(FontAwesomeIcons.pencil, size: 16),
                            onPressed: () {}),
                    const SizedBox(width: 5),
                    const Text("ส่วนสูง : ",
                        style: TextStyle(fontSize: 16, fontFamily: 'Mitr')),
                    const SizedBox(width: 5),
                    Text("$height cm.",
                        style:
                            const TextStyle(fontSize: 16, fontFamily: 'Mitr')),
                    FirebaseAuth.instance.currentUser !=
                            FirebaseAuth.instance.currentUser
                        ? IconButton(
                            icon:
                                const FaIcon(FontAwesomeIcons.pencil, size: 16),
                            onPressed: () {
                              Widget agree = TextButton(
                                  child: const Text('ตกลง'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  });
                              Widget cancel = TextButton(
                                  child: const Text('ยกเลิก'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  });
                              AlertDialog alert = AlertDialog(
                                  insetPadding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  title: const Text(
                                    "ส่วนสูงเท่าไหร่",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Mitr'),
                                  ),
                                  content: TextFormField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9.]+')),
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: const InputDecoration(
                                        labelText: 'เซนติเมตร',
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (String value) async {
                                        setState(() {
                                          height = int.parse(value);
                                        });
                                      }),
                                  actions: <Widget>[agree, cancel]);

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  });
                            })
                        : IconButton(
                            icon:
                                const FaIcon(FontAwesomeIcons.pencil, size: 16),
                            onPressed: () {}),
                  ])),
              Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(children: const [
                        Icon(Icons.keyboard_arrow_right, size: 16),
                        Text("รูปแบบท่องเที่ยว",
                            style: TextStyle(fontSize: 16, fontFamily: 'Mitr')),
                        SizedBox(width: 10),
                        Text("(ได้มากกว่า 1 ตัวเลือก)",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Mitr',
                                color: Colors.grey))
                      ]))),
              Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(children: [
                        RadioListTile(
                            title: Text(travel[0]),
                            value: 1,
                            groupValue: radiotravel[0],
                            toggleable: true,
                            onChanged: (value) {
                              setState(() {
                                radiotravel[0] = value;
                              });
                            }),
                        RadioListTile(
                            title: Text(travel[1]),
                            value: 2,
                            groupValue: radiotravel[1],
                            toggleable: true,
                            onChanged: (value) {
                              setState(() {
                                radiotravel[1] = value;
                              });
                            }),
                        RadioListTile(
                            title: Text(travel[2]),
                            value: 3,
                            groupValue: radiotravel[2],
                            toggleable: true,
                            onChanged: (value) {
                              setState(() {
                                radiotravel[2] = value;
                              });
                            })
                      ]))),
              Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(children: const [
                        Icon(Icons.keyboard_arrow_right, size: 16),
                        Text("สไตล์การท่องเที่ยว",
                            style: TextStyle(fontSize: 16, fontFamily: 'Mitr')),
                        SizedBox(width: 10),
                        Text("(ได้มากกว่า 1 ตัวเลือก)",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Mitr',
                                color: Colors.grey))
                      ]))),
              Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(children: [
                        RadioListTile(
                            title: Text(travelstyle[0]),
                            subtitle: const Text(
                                "กิจกรรมท้าทาย เช่น ปีนเขา , ดำน้ำ , เดินป่า , เครื่องเล่นต่างๆ"),
                            value: 1,
                            groupValue: radiotravelstyle[0],
                            toggleable: true,
                            onChanged: (value) {
                              setState(() {
                                radiotravelstyle[0] = value;
                              });
                            }),
                        RadioListTile(
                            title: Text(travelstyle[1]),
                            subtitle: const Text("ตลาดนัท , ร้านอาหาร , คาเฟ่"),
                            value: 2,
                            groupValue: radiotravelstyle[1],
                            toggleable: true,
                            onChanged: (value) {
                              setState(() {
                                radiotravelstyle[1] = value;
                              });
                            }),
                        RadioListTile(
                            title: Text(travelstyle[2]),
                            subtitle: const Text(
                                "พิพิธภัณฑ์ , สถาปัตยกรรม , จิตรกรรม"),
                            value: 3,
                            groupValue: radiotravelstyle[2],
                            toggleable: true,
                            onChanged: (value) {
                              setState(() {
                                radiotravelstyle[2] = value;
                              });
                            }),
                        RadioListTile(
                            title: Text(travelstyle[3]),
                            subtitle: const Text("ทะเล , ภูเขา , น้ำตก"),
                            value: 4,
                            groupValue: radiotravelstyle[3],
                            toggleable: true,
                            onChanged: (value) {
                              setState(() {
                                radiotravelstyle[3] = value;
                              });
                            }),
                        RadioListTile(
                            title: Text(travelstyle[4]),
                            subtitle: const Text("ตลาดนัท , ห้าง"),
                            value: 5,
                            groupValue: radiotravelstyle[4],
                            toggleable: true,
                            onChanged: (value) {
                              setState(() {
                                radiotravelstyle[4] = value;
                              });
                            }),
                        RadioListTile(
                            title: Text(travelstyle[5]),
                            subtitle: const Text(
                                "มีศิลปินมาร้องเพลงให้ฟังตามงานต่างๆ"),
                            value: 6,
                            groupValue: radiotravelstyle[5],
                            toggleable: true,
                            onChanged: (value) {
                              setState(() {
                                radiotravelstyle[5] = value;
                              });
                            })
                      ]))),
              Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(children: const [
                        Icon(Icons.keyboard_arrow_right, size: 16),
                        Text("รูปแบบการเลือกร้านอาหาร",
                            style: TextStyle(fontSize: 16, fontFamily: 'Mitr')),
                        SizedBox(width: 10),
                        Text("(ได้มากกว่า 1 ตัวเลือก)",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Mitr',
                                color: Colors.grey))
                      ]))),
              Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(children: [
                        RadioListTile(
                            title: Text(restaurant[0]),
                            subtitle: const Text("มีคนกินเยอะ , ร้านมิชลิน"),
                            value: 1,
                            groupValue: radiores[0],
                            toggleable: true,
                            onChanged: (value) {
                              setState(() {
                                radiores[0] = value;
                              });
                            }),
                        RadioListTile(
                            title: Text(restaurant[1]),
                            subtitle: const Text("เมนูคนนิยมมีให้เลือกเยอะ"),
                            value: 2,
                            groupValue: radiores[1],
                            toggleable: true,
                            onChanged: (value) {
                              setState(() {
                                radiores[1] = value;
                              });
                            }),
                        RadioListTile(
                            title: Text(restaurant[2]),
                            subtitle: const Text("มีต้นไม้ ดอกไม้ อากาศสดชื่น"),
                            value: 3,
                            groupValue: radiores[2],
                            toggleable: true,
                            onChanged: (value) {
                              setState(() {
                                radiores[2] = value;
                              });
                            }),
                        RadioListTile(
                            title: Text(restaurant[3]),
                            subtitle: const Text("ถูกหรือแพง และ จับต้องได้"),
                            value: 4,
                            groupValue: radiores[3],
                            toggleable: true,
                            onChanged: (value) {
                              setState(() {
                                radiores[3] = value;
                              });
                            }),
                        RadioListTile(
                            title: Text(restaurant[4]),
                            subtitle: const Text(
                                "Fast Food , Fast Casual , Casual  , Fine Dining , Buffet"),
                            value: 5,
                            groupValue: radiores[4],
                            toggleable: true,
                            onChanged: (value) {
                              setState(() {
                                radiores[4] = value;
                              });
                            })
                      ]))),
            ],
          ),
        ));
  }
}
