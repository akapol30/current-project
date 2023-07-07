import 'package:flutter/material.dart';
class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {
                //Navigator.of(context).push(MaterialPageRoute(
                //   builder: (BuildContext context) => MyApp()));
              },
            )
          ],
          title: const Text("เกี่ยวกับ",
              style: TextStyle(fontFamily: 'Mitr')),
        ),
        body: SingleChildScrollView(child: Container()));
  }
}