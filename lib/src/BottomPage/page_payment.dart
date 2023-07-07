import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
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
          title: const Text("จ่ายเงิน",
              style: TextStyle(fontFamily: 'Mitr')),
        ),
        body: SingleChildScrollView(child: Container()));
  }
}
