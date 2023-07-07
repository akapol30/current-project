import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:min_id/min_id.dart';
import 'package:project_towin/src/modelclass/class_book.dart';
import 'package:project_towin/src/modelclass/class_getingtext.dart';

import 'package:reorderable_grid_view/reorderable_grid_view.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

class AddTravelNorth extends StatefulWidget {
  const AddTravelNorth({Key? key}) : super(key: key);

  @override
  State<AddTravelNorth> createState() => _AddTravelNorthState();
}

class _AddTravelNorthState extends State<AddTravelNorth> {
  Foodsql myFoodbook = Foodsql(
      foodname: '',
      foodtype: '',
      namepro: '',
      picpro: '',
      time: '',
      dianamepro: '',
      diapicpro: '',
      diatime: '',
      note: '',
      flav: '',
      region: '',
      recipetype: '',
      ingredient: [],
      quantity: [],
      uom: [],
      step: [],
      pic: [],
      dianote: [],
      nutrients: [],
      nutweight: [],
      nutpercent: [],
      rating: 0.0,
      favorite: false,
      id: '');

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  // ignore: prefer_final_fields
  CollectionReference _tableFoodbook =
      FirebaseFirestore.instance.collection("ListRecipesNorth");
  final user = FirebaseAuth.instance.currentUser!;
  static int countIng = 0, countStep = 0;

  final formKey = GlobalKey<FormState>();

  var date = DateTime.now();
  var formattedDate = DateFormat('dd - MM - yyyy');

  List<Ingdata> foodsIng = List.generate(countIng, (index) => Ingdata());
  List<Stepdata> foodsStep = List.generate(countStep, (index) => Stepdata());

  void _saveIngToDataBase() {
    for (int i = 0; i < foodsIng.length; i++) {
      myFoodbook.ingredient!.add(foodsIng[i].ingname!);
      myFoodbook.quantity!.add(foodsIng[i].quantity!);
      myFoodbook.uom!.add(foodsIng[i].uom!);
    }
  }

  void _saveStepToDataBase() {
    for (int i = 0; i < foodsStep.length; i++) {
      myFoodbook.step!.add(foodsStep[i].step!);
    }
  }

  void _onListCountChangeIng(int value) {
    setState(() {
      countIng = value;
      foodsIng = List.generate(
          countIng, (index) => Ingdata(ingname: '', quantity: '', uom: ''));
    });
  }

  void _onListCountChangeStep(int value) {
    setState(() {
      countStep = value;
      foodsStep = List.generate(countStep, (index) => Stepdata(step: ''));
    });
  }

  String? selectedValueRg, selectedValueRp, selectedValuefood;
  List? categoryItemList;

  /*List<String> items = [
    'เลือก',
    'ตามชอบ',
    'ช้อนชา',
    'ช้อนโต๊ะ',
    'ทัพพี',
    'ถ้วย',
    'ออนซ์',
    'ปอนด์',
    'มิลลิลิตร',
    'ลิตร',
    'มิลลิกรัม',
    'กรัม',
    'กิโลกรัม',
    'แท่ง',
    'ฟอง',
    'ชิ้น',
    'อัน',
    'ลูก',
    'หลอด',
    'ซีก',
    'หัว',
    'กลีบ',
    'กำมือ',
    'หยิบมือ',
    'ตัว',
    'เส้น',
    'ต้น',
    'ใบ',
    'ราก',
    'ดอก',
    'เม็ด'
  ];*/

  List<File> images = [];
  UploadTask? uploadTask;

  PlatformFile? files;

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
                title: const Text("แบบฟอร์มรายละเอียดอาหาร",
                    style: TextStyle(fontFamily: 'Mitr')),
              ),
              body: SingleChildScrollView(
                  child: Form(
                      key: formKey,
                      child: Column(children: [
                        const SizedBox(height: 10),
                        files == null ? defaultImg(context) : multiImg(context),
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
                              hint: const Text("ประเภทสูตร"),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedValueRp = newValue!;
                                });
                              },
                              items: <String>[
                                'Food',
                                'Beverage',
                                'Dessert',
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
                              value: selectedValuefood,
                              isExpanded: true,
                              hint: const Text("ประเภทอาหาร"),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedValuefood = newValue!;
                                });
                              },
                              items: <String>[
                                'อาหารตามสั่ง',
                                'อาหารเช้า',
                                'อาหารป่า',
                                'อาหารจานเดียว',
                                'อาหารทะเล',
                                'อาหารเจ',
                                'ติ่มซำ',
                                'น้ำพริก',
                                'อาหารคลีน/สลัด',
                                'ก๋วยเตี๋ยว',
                                'ติ่มซำ',
                                'น้ำผลไม้',
                                'ชานมไข่มุก',
                                'กาแฟ',
                                'เครื่องดื่มแอลกอฮอล์',
                                'เบเกอรี/เค้ก',
                                'ของหวาน',
                                'คุ๊กกี้',
                                'ไอศกรีม',
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
                                  labelText: 'ชื่ออาหาร',
                                  border: OutlineInputBorder(),
                                ),
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนชื่ออาหาร ^^"),
                                onSaved: (value) {
                                  myFoodbook.foodname = value!.trim();
                                },
                              )),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const SizedBox(width: 40),
                            const Text("จำนวนวัตถุดิบทั้งหมด",
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
                                  if (countIng > 30) {
                                    return 'ใส่ได้ <= 30';
                                  }
                                  return null;
                                }),
                                onChanged: (value) {
                                  try {
                                    _onListCountChangeIng(int.parse(value));
                                  } catch (e) {
                                    _onListCountChangeIng(0);
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
                                        itemCount: countIng,
                                        itemBuilder: (context, index) {
                                          return _multiIng(index);
                                        }))),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(children: [
                          const SizedBox(width: 40),
                          const Text("จำนวนขั้นตอนทั้งหมด",
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
                                  if (countStep > 20) {
                                    return 'ใส่ได้ <= 20';
                                  }
                                  return null;
                                }),
                                onChanged: (value) {
                                  try {
                                    _onListCountChangeStep(int.parse(value));
                                  } catch (e) {
                                    _onListCountChangeStep(0);
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
                                        itemCount: countStep,
                                        itemBuilder: (context, index) {
                                          return _multiStep(index);
                                        }))),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
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
                                    myFoodbook.note = value!.trim();
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
                                    myFoodbook.id = MinId.getId();
                                    myFoodbook.foodtype = selectedValuefood!;

                                    myFoodbook.region = selectedValueRg!;

                                    myFoodbook.recipetype = selectedValueRp!;

                                    myFoodbook.namepro = user.displayName!;

                                    myFoodbook.picpro = user.photoURL!;

                                    myFoodbook.time =
                                        formattedDate.format(date);
                                    _saveIngToDataBase();
                                    _saveStepToDataBase();
                                    formKey.currentState?.save();
                                    //UPloadPicStorage();

                                    await _tableFoodbook.add({
                                      "Bid": myFoodbook.id,
                                      "Bfoodtype": myFoodbook.foodtype,
                                      "Bfoodname": myFoodbook.foodname,
                                      "Bingredient": myFoodbook.ingredient,
                                      "Bquantity": myFoodbook.quantity,
                                      "Bfavorite": myFoodbook.favorite,
                                      "Buom": myFoodbook.uom,
                                      "Bstep": myFoodbook.step,
                                      "Bnote": myFoodbook.note,
                                      "Bpicfood": myFoodbook.pic,
                                      "Bnamepro": myFoodbook.namepro,
                                      "Bpicpro": myFoodbook.picpro,
                                      "Btime": myFoodbook.time,
                                      "BRating": myFoodbook.rating,
                                      "Bdialoguename": myFoodbook.dianamepro,
                                      "Bdialoguepic": myFoodbook.diapicpro,
                                      "Bdialoguetime": myFoodbook.diatime,
                                      "Bdialoguenote": myFoodbook.dianote,
                                      "Bregion": myFoodbook.region,
                                      "Brecipetype": myFoodbook.recipetype,
                                      "Bflav": myFoodbook.flav,
                                      "Bnutname": myFoodbook.nutrients,
                                      "Bnutweight": myFoodbook.nutweight,
                                      "Bnutpercent": myFoodbook.nutpercent
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

            if (result != null) {
              images = result.paths.map((path) => File(path!)).toList();
              setState(() {
                files = result.files.first;
              });
              final uploadTasks = images.map((file) async {
                String uniqueFilename = "${DateTime.now()}-food";
                Reference refRoot = FirebaseStorage.instance.ref();
                Reference refDirImages = refRoot.child('images');
                Reference refImageToUpload = refDirImages.child(uniqueFilename);
                await refImageToUpload.putFile(File(file.path));
                return await refImageToUpload.getDownloadURL();
              });
              final urls = await Future.wait(uploadTasks);
              for (int i = 0; i < urls.length; i++) {
                myFoodbook.pic!.add(urls[i]);
              }
            }
          },
          child: Ink.image(image: const AssetImage('assets/images/pic2.png')),
        ));
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

              if (result != null) {
                images = result.paths.map((path) => File(path!)).toList();
                setState(() {
                  files = result.files.first;
                });
                final uploadTasks = images.map((file) async {
                  String uniqueFilename = "${DateTime.now()}-food";
                  Reference refRoot = FirebaseStorage.instance.ref();
                  Reference refDirImages = refRoot.child('images');
                  Reference refImageToUpload =
                      refDirImages.child(uniqueFilename);
                  await refImageToUpload.putFile(File(file.path));
                  return await refImageToUpload.getDownloadURL();
                });

                final urls = await Future.wait(uploadTasks);
                for (int i = 0; i < urls.length; i++) {
                  myFoodbook.pic!.add(urls[i]);
                }
              }
            },
            child: SizedBox(
              height: 200,
              child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ReorderableGridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    children: images
                        .map((path) => Card(
                              color: Colors.amber.shade200,
                              key: ValueKey(path),
                              child: Image.file(path),
                            ))
                        .toList(),
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        File img = images.removeAt(oldIndex);
                        images.insert(newIndex, img);
                      });
                    },
                  )),
            )));
  }

  _multiStep(int index) {
    return Row(children: [
      Text("${index + 1}", style: const TextStyle(fontSize: 20)),
      const SizedBox(width: 10),
      SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'ขั้นตอน',
              border: OutlineInputBorder(),
            ),
            initialValue: foodsStep[index].step,
            //validator: RequiredValidator(errorText: "กรุณาป้อนขั้นตอนการทำ ^^"),
            onChanged: (v) {
              foodsStep[index].step = v;
            },
          ))
    ]);
  }

  _multiIng(int index) {
    return Row(
      children: [
        Text(
          "${index + 1}",
          style: const TextStyle(fontSize: 18),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Container(
                padding: const EdgeInsets.only(left: 12),
                width: MediaQuery.of(context).size.width * 0.28,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'วัตถุดิบ',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: foodsIng[index].ingname,
                  //validator:
                  //    RequiredValidator(errorText: "กรุณาป้อนชื่อวัตถุดิบ ^^"),
                  onChanged: (v) {
                    foodsIng[index].ingname = v;
                  },
                ))),
        const SizedBox(width: 10),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'จำนวน',
                border: OutlineInputBorder(),
              ),
              initialValue: foodsIng[index].quantity,
              //validator:
              //    RequiredValidator(errorText: "กรุณาป้อนจำนวนวัตถุดิบ ^^"),
              onChanged: (c) {
                foodsIng[index].quantity = c;
              },
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
            )),
        const SizedBox(width: 15),
        Align(
            alignment: Alignment.centerRight,
            child: Container(
                padding: const EdgeInsets.only(right: 20),
                width: MediaQuery.of(context).size.width * 0.30,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'หน่วย',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: foodsIng[index].uom,
                  //validator:
                  //    RequiredValidator(errorText: "กรุณาป้อนหน่วยวัตถุดิบ ^^"),
                  onChanged: (v) {
                    foodsIng[index].uom = v;
                  },
                ))),
      ],
    );
  }
}
