import 'package:flutter/material.dart';
class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
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
          title: const Text("กระเป๋าตัง",
              style: TextStyle(fontFamily: 'Mitr')),
        ),
        body: SingleChildScrollView(child: Container()));
  }
}