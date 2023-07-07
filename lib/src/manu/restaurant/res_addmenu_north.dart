import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:project_towin/src/modelclass/class_getingtext.dart';

import 'package:min_id/min_id.dart';
import 'package:project_towin/src/modelclass/class_store.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

class AddResNorth extends StatefulWidget {
  const AddResNorth({Key? key}) : super(key: key);

  @override
  State<AddResNorth> createState() => _AddResNorthState();
}

class _AddResNorthState extends State<AddResNorth> {
  storesql mystore = storesql(
      id: '',
      storename: '',
      province: '',
      namepro: '',
      picpro: '',
      timeopen: '',
      timepost: '',
      favorite: false,
      dianamepro: '',
      diapicpro: '',
      diatime: '',
      note: '',
      foodname: [],
      picStore: [],
      picfood: [],
      price: [],
      dianote: [],
      region: '',
      storetype: '',
      flav: '',
      dayopen: '',
      diafav: 0,
      diapicdes: [],
      email: '',
      fooddes: [],
      lat: 0.0,
      lng: 0.0,
      user: [],
      dayoff: '',
      tel: [],
      url: [],
      rating: 0.0);

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  // ignore: prefer_final_fields
  CollectionReference _tableStore =
      FirebaseFirestore.instance.collection("ListStoreNorth");
  final user = FirebaseAuth.instance.currentUser!;

  final formKey = GlobalKey<FormState>();

  var date = DateTime.now();
  var formattedDate = DateFormat('dd - MM - yyyy');

  String? selectedValueRg, selectedValueRp, selectedValueprovince;
  List? categoryItemList;
  static int countTel = 0, countDes = 0;
  List<Teldata> telStore = List.generate(countTel, (index) => Teldata());
  List<Desdata> foodData = List.generate(countDes, (index) => Desdata());
  void _saveTelToDataBase() {
    for (int i = 0; i < telStore.length; i++) {
      mystore.tel!.add(telStore[i].tel!);
    }
  }

  void _saveFoodToDataBase() {
    for (int i = 0; i < foodData.length; i++) {
      mystore.foodname!.add(foodData[i].foodname!);
      mystore.fooddes!.add(foodData[i].description!);
      mystore.price!.add(foodData[i].price!);
    }
  }

  void _onListCountChangeTel(int value) {
    setState(() {
      countTel = value;
      telStore = List.generate(countTel, (index) => Teldata(tel: ''));
    });
  }

  void _onListCountChangeDes(int value) {
    setState(() {
      countDes = value;
      foodData = List.generate(countDes,
          (index) => Desdata(foodname: '', description: '', price: ''));
    });
  }

  void _saveImageStoreToDataBase() async {
    final uploadTasks = imagesstore.map((file) async {
      String uniqueFilename = "${DateTime.now()}-store";
      Reference refRoot = FirebaseStorage.instance.ref();
      Reference refDirImages = refRoot.child('images/Store');
      Reference refImageToUpload = refDirImages.child(uniqueFilename);
      await refImageToUpload.putFile(File(file.path));
      return await refImageToUpload.getDownloadURL();
    });
    final urls = await Future.wait(uploadTasks);
    for (int i = 0; i < urls.length; i++) {
      mystore.picStore!.add(urls[i]);
    }
  }

  void _saveImageFoodToDataBase() async {
    final uploadTasks = imagesfood.map((file) async {
      String uniqueFilename = "${DateTime.now()}-store";
      Reference refRoot = FirebaseStorage.instance.ref();
      Reference refDirImages = refRoot.child('images/Store');
      Reference refImageToUpload = refDirImages.child(uniqueFilename);
      await refImageToUpload.putFile(File(file.path));
      return await refImageToUpload.getDownloadURL();
    });
    final urls = await Future.wait(uploadTasks);
    for (int i = 0; i < urls.length; i++) {
      mystore.picfood!.add(urls[i]);
    }
  }

  List<File> imagesstore = [], imagesfood = [];
  UploadTask? uploadTask;

  PlatformFile? files, filesfood;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(
                  "${snapshot.error}",
                  style:
                      const TextStyle(fontSize: 20.0, fontFamily: 'MitrLight'),
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.navigate_before),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.pageview),
                    onPressed: () {
                      //Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //   builder: (BuildContext context) => MyApp()));
                    },
                  )
                ],
                title: const Text("แบบฟอร์มรายละเอียดร้านอาหาร",
                    style: TextStyle(fontFamily: 'Mitr')),
              ),
              body: SingleChildScrollView(
                  child: Form(
                      key: formKey,
                      child: Column(children: [
                        const SizedBox(height: 10),
                        imagesstore.length <= 1
                            ? defaultImg(context)
                            : multiImg(context),
                        const SizedBox(height: 15),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: DropdownButton<String>(
                              value: selectedValueRg,
                              isExpanded: true,
                              hint: const Text("ภูมิภาค"),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedValueRg = newValue!;
                                });
                              },
                              items: <String>[
                                'ภาคเหนือ',
                                'ภาคอีสาน',
                                'ภาคตะวันตก',
                                'ภาคกลาง',
                                'ภาคตะวันออก',
                                'ภาคใต้',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: DropdownButton<String>(
                              value: selectedValueRp,
                              isExpanded: true,
                              hint: const Text("ประเภทร้านอาหาร"),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedValueRp = newValue!;
                                });
                              },
                              items: <String>[
                                'คลาสสิก',
                                'อินดี้',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: DropdownButton<String>(
                              value: selectedValueprovince,
                              isExpanded: true,
                              hint: const Text("จังหวัดร้าน"),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedValueprovince = newValue!;
                                });
                              },
                              items: <String>[
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
                                "อุทัยธานี",
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
                        const SizedBox(height: 15),
                        Center(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: const InputDecoration(
                                  labelText: 'ชื่อร้านอาหาร',
                                  border: OutlineInputBorder(),
                                ),
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนชื่อร้านอาหาร ^^"),
                                onSaved: (value) {
                                  mystore.storename = value!.trim();
                                },
                              )),
                        ),
                        const SizedBox(height: 15),
                        Center(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: const InputDecoration(
                                  labelText: 'วันเปิดถึงวันปิด',
                                  border: OutlineInputBorder(),
                                ),
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนวันที่ ^^"),
                                onSaved: (value) {
                                  mystore.dayopen = value!.trim();
                                },
                              )),
                        ),
                        const SizedBox(height: 15),
                        Center(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: const InputDecoration(
                                  labelText: 'เวลาเปิดถึงเวลาปิด',
                                  border: OutlineInputBorder(),
                                ),
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนเวลา ^^"),
                                onSaved: (value) {
                                  mystore.timeopen = value!.trim();
                                },
                              )),
                        ),
                        const SizedBox(height: 15),
                        Center(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: const InputDecoration(
                                  labelText: 'วันหยุด',
                                  border: OutlineInputBorder(),
                                ),
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนวันหยุด ^^"),
                                onSaved: (value) {
                                  mystore.dayoff = value!.trim();
                                },
                              )),
                        ),
                        const SizedBox(height: 15),
                        const Center(
                            child: Text(
                          "เมนูแนะนำสูงสุด 5 เมนู",
                          style: TextStyle(fontSize: 20),
                        )),
                        const SizedBox(height: 15),
                        imagesfood.length <= 1
                            ? defaultImgFood(context)
                            : multiImgFood(context),
                        const SizedBox(height: 15),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const SizedBox(width: 40),
                            const Text("จำนวนเมนูแนะนำทั้งหมด",
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'Mitr')),
                            const SizedBox(width: 15),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(2),
                                ],
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: const InputDecoration(
                                  labelText: 'จำนวน',
                                  border: OutlineInputBorder(),
                                ),
                                validator: ((value) {
                                  if (countDes > 5) {
                                    return 'ไม่เกิน 5';
                                  }
                                  return null;
                                }),
                                onChanged: (value) {
                                  try {
                                    _onListCountChangeDes(int.parse(value));
                                  } catch (e) {
                                    _onListCountChangeDes(0);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                                child: Container(
                                    color: Colors.yellow.shade100,
                                    height: 200,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: ListView.builder(
                                        itemCount: countDes,
                                        itemBuilder: (context, index) {
                                          return _multiFood(index);
                                        }))),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Row(children: [
                          const SizedBox(width: 40),
                          const Text("จำนวนเบอร์ติดต่อทั้งหมด",
                              style:
                                  TextStyle(fontSize: 20, fontFamily: 'Mitr')),
                          const SizedBox(width: 15),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(2),
                                ],
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: const InputDecoration(
                                  labelText: 'จำนวน',
                                  border: OutlineInputBorder(),
                                ),
                                validator: ((value) {
                                  if (countTel > 10) {
                                    return 'ไม่เกิน 10';
                                  }
                                  return null;
                                }),
                                onChanged: (value) {
                                  try {
                                    _onListCountChangeTel(int.parse(value));
                                  } catch (e) {
                                    _onListCountChangeTel(0);
                                  }
                                },
                              )),
                          const SizedBox(width: 20),
                        ]),
                        const SizedBox(height: 16),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                                child: Container(
                                    color: Colors.orange.shade100,
                                    height: 130,
                                    width: MediaQuery.of(context).size.width *
                                        0.90,
                                    child: ListView.builder(
                                        itemCount: countTel,
                                        itemBuilder: (context, index) {
                                          return _multiTel(index);
                                        }))),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                        Row(children: [
                          const SizedBox(
                            width: 30,
                          ),
                          const Text("พิกัดร้าน : ",
                              style:
                                  TextStyle(fontSize: 20, fontFamily: 'Mitr')),
                          Center(
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Latitude',
                                    border: OutlineInputBorder(),
                                  ),
                                  onSaved: (value) {
                                    if (value == '') {
                                      value = null;
                                    } else {
                                      mystore.lat = double.parse(value!.trim());
                                    }
                                  },
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Center(
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Longitude',
                                    border: OutlineInputBorder(),
                                  ),
                                  onSaved: (value) {
                                    if (value == '') {
                                      value = null;
                                    } else {
                                      mystore.lng = double.parse(value!.trim());
                                    }
                                  },
                                )),
                          )
                        ]),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 5,
                                decoration: const InputDecoration(
                                  labelText: 'หมายเหตุ:(ถ้ามี)',
                                  border: OutlineInputBorder(),
                                ),
                                onSaved: (value) {
                                  if (value == '') {
                                    value = null;
                                  } else {
                                    mystore.note = value!.trim();
                                  }
                                },
                              )),
                        ),
                        const SizedBox(height: 16),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Stack(children: <Widget>[
                              Positioned.fill(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        Color.fromARGB(255, 203, 105, 6),
                                        Color.fromARGB(255, 252, 137, 22),
                                        Color.fromARGB(255, 255, 178, 102),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(16.0),
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    mystore.id = MinId.getId();

                                    _saveTelToDataBase();
                                    _saveFoodToDataBase();
                                    _saveImageFoodToDataBase();
                                    _saveImageStoreToDataBase();
                                    formKey.currentState?.save();
                                    //UPloadPicStorage();

                                    await _tableStore.add({
                                      "Sid": mystore.id,
                                      "Sstorename": mystore.storename,
                                      "Sstoretype": mystore.storetype,
                                      "Snamepro": mystore.namepro,
                                      "Spicpro": mystore.picpro,
                                      "Stimepost": mystore.timepost,
                                      "Stimeopen": mystore.timeopen,
                                      "Sdayopen": mystore.dayopen,
                                      "Sdianamepro": mystore.dianamepro,
                                      "Sdiapicpro": mystore.diapicpro,
                                      "Sdiatime": mystore.diatime,
                                      "Snote": mystore.note,
                                      "Sflav": mystore.flav,
                                      "Sregion": mystore.region,
                                      "Sdayoff": mystore.dayoff,
                                      "Sprovince": mystore.province,
                                      "Semail": mystore.email,
                                      "Sfoodname": mystore.foodname,
                                      "Sfooddes": mystore.fooddes,
                                      "SpicStore": mystore.picStore,
                                      "Spicfood": mystore.picfood,
                                      "Sdianote": mystore.dianote,
                                      "Sprice": mystore.price,
                                      "Sdiapicdes": mystore.diapicdes,
                                      "Stel": mystore.tel,
                                      "Suser": mystore.user,
                                      "Surl": mystore.url,
                                      "Sdiafav": mystore.diafav,
                                      "Srating": mystore.rating,
                                      "Slat": mystore.lat,
                                      "Slng": mystore.lng,
                                      "Sfavorite": mystore.favorite,
                                    });
                                    formKey.currentState?.reset();
                                  }

                                  //Navigator.pop(context);
                                },
                                child: const Text('ยืนยันคำขอ',
                                    style: TextStyle(fontFamily: 'Mitr')),
                              ),
                            ]))
                      ]))),
            );
          }

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  _multiFood(int index) {
    return Row(children: [
      Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text("${index + 1}", style: const TextStyle(fontSize: 20))),
      const SizedBox(
        width: 10,
      ),
      SizedBox(
          height: 210,
          child: Column(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'ชื่ออาหาร',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: foodData[index].foodname,
                        //validator:
                        //    RequiredValidator(errorText: "กรุณาป้อนชื่อวัตถุดิบ ^^"),
                        onChanged: (v) {
                          foodData[index].foodname = v;
                        },
                      ))),
              const SizedBox(width: 10),
              Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        maxLength: 40,
                        decoration: const InputDecoration(
                          labelText: 'คำอธิบาย',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: foodData[index].description,
                        //validator:
                        //    RequiredValidator(errorText: "กรุณาป้อนจำนวนวัตถุดิบ ^^"),
                        onChanged: (c) {
                          foodData[index].description = c;
                        },
                      ))),
              const SizedBox(width: 15),
              Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'ราคา',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        initialValue: foodData[index].price.toString(),
                        //validator:
                        //    RequiredValidator(errorText: "กรุณาป้อนหน่วยวัตถุดิบ ^^"),
                        onChanged: (v) {
                          foodData[index].price = v;
                        },
                      ))),
            ],
          ))
    ]);
  }

  _multiTel(int index) {
    return Row(children: [
      Text("${index + 1}", style: const TextStyle(fontSize: 20)),
      const SizedBox(width: 10),
      SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'เบอร์ติดต่อ',
              border: OutlineInputBorder(),
            ),
            initialValue: telStore[index].tel,
            //validator: RequiredValidator(errorText: "กรุณาป้อนขั้นตอนการทำ ^^"),
            onChanged: (v) {
              telStore[index].tel = v;
            },
          ))
    ]);
  }

  Widget defaultImg(BuildContext context) {
    return Container(
        decoration: BoxDecoration(border: Border.all(width: 5)),
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.3,
        child: InkWell(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                allowMultiple: true,
                type: FileType.custom,
                allowedExtensions: ['jpg', 'png', 'jpeg'],
              );
              try {
                if (result!.count <= 1) {
                  imagesstore =
                      result.paths.map((path) => File(path!)).toList();
                  setState(() {
                    files = result.files.first;
                  });
                } else {
                  if (result.count <= 5) {
                    imagesstore =
                        result.paths.map((path) => File(path!)).toList();
                    setState(() {
                      files = result.files.first;
                    });
                  } else {
                    const snackBar = SnackBar(
                      content: Text('ใส่รูปสูงสุดได้แค่ 5 รูป'),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              } catch (e) {
                print(e);
              }
            },
            child: Ink.image(
                image: const AssetImage('assets/images/pic2.png'),
                child: manageImageStore())));
  }

  Widget multiImg(BuildContext context) {
    return Container(
        decoration: BoxDecoration(border: Border.all(width: 5)),
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.3,
        child: InkWell(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                allowMultiple: true,
                type: FileType.custom,
                allowedExtensions: ['jpg', 'png', 'jpeg'],
              );

              try {
                if (result!.count <= 5) {
                  imagesstore =
                      result.paths.map((path) => File(path!)).toList();
                  setState(() {
                    files = result.files.first;
                  });
                } else {
                  const snackBar = SnackBar(
                    content: Text('ใส่รูปสูงสุดได้แค่ 5 รูป'),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              } catch (e) {
                print(e);
              }
            },
            child: manageImageStore()));
  }

  Widget defaultImgFood(BuildContext context) {
    return Container(
        decoration: BoxDecoration(border: Border.all(width: 5)),
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.3,
        child: InkWell(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                allowMultiple: true,
                type: FileType.custom,
                allowedExtensions: ['jpg', 'png', 'jpeg'],
              );
              try {
                if (result!.count <= 1) {
                  imagesfood = result.paths.map((path) => File(path!)).toList();
                  setState(() {
                    filesfood = result.files.first;
                  });
                } else {
                  if (result.count <= 5) {
                    imagesfood =
                        result.paths.map((path) => File(path!)).toList();
                    setState(() {
                      filesfood = result.files.first;
                    });
                  } else {
                    const snackBar = SnackBar(
                      content: Text('ใส่รูปสูงสุดได้แค่ 5 รูป'),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              } catch (e) {
                print(e);
              }
            },
            child: Ink.image(
                image: const AssetImage('assets/images/pic2.png'),
                child: manageImagefood())));
  }

  Widget multiImgFood(BuildContext context) {
    return Container(
        decoration: BoxDecoration(border: Border.all(width: 5)),
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.3,
        child: InkWell(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                allowMultiple: true,
                type: FileType.custom,
                allowedExtensions: ['jpg', 'png', 'jpeg'],
              );
              try {
                if (result!.count <= 5) {
                  imagesfood = result.paths.map((path) => File(path!)).toList();
                  setState(() {
                    filesfood = result.files.first;
                  });
                } else {
                  const snackBar = SnackBar(
                    content: Text('ใส่รูปสูงสุดได้แค่ 5 รูป'),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              } catch (e) {
                print(e);
              }
            },
            child: manageImagefood()));
  }

  SizedBox manageImageStore() {
    return SizedBox(
        height: 200,
        child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: imagesstore.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Stack(children: [
                    SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.file(
                          File(imagesstore[index].path),
                          fit: BoxFit.cover,
                        )),
                    Positioned(
                        left: 35,
                        bottom: 35,
                        child: IconButton(
                          icon: const Icon(Icons.cancel),
                          color: Colors.red,
                          onPressed: () {
                            setState(() {
                              imagesstore.remove(imagesstore[index]);
                            });
                          },
                        ))
                  ]),
                );
              },
            )));
  }

  SizedBox manageImagefood() {
    return SizedBox(
        height: 200,
        child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: imagesfood.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Stack(children: [
                    SizedBox(
                        height: 100,
                        width: 100,
                        child: Image.file(
                          File(imagesfood[index].path),
                          fit: BoxFit.cover,
                        )),
                    Positioned(
                        left: 35,
                        bottom: 35,
                        child: IconButton(
                          icon: const Icon(Icons.cancel),
                          color: Colors.red,
                          onPressed: () {
                            setState(() {
                              imagesfood.remove(imagesfood[index]);
                            });
                          },
                        ))
                  ]),
                );
              },
            )));
  }
}
