import 'package:flutter/material.dart';
import 'package:project_towin/src/Comment/comment_values.dart';
import 'package:project_towin/src/Comment/postcard.dart';
import 'package:project_towin/src/page/homepage.dart';

class ResConverseNorth extends StatefulWidget {
  const ResConverseNorth({super.key});

  @override
  State<ResConverseNorth> createState() => _ResConverseNorthState();
}

class _ResConverseNorthState extends State<ResConverseNorth> {
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.amber.shade100,
            appBar: AppBar(
              backgroundColor: Colors.amber,
              centerTitle: true,
              title: Text("Store"),
            ),
            body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.87,
                    child: Column(children: [
                      ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(user.photoURL!),
                          ),
                          title: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16)),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => const FunkyOverlay(),
                              );
                            },
                            child: const Text('Write is comment...'),
                          )),
                      Expanded(
                        child: ListView.builder(
                          itemCount: CommentValues.posts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TravelPostCardNorth(
                                postData: CommentValues.posts[index]);
                          },
                        ),
                      ),
                    ])))));
  }
}

class FunkyOverlay extends StatefulWidget {
  const FunkyOverlay({super.key});

  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
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
                ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(user.photoURL!),
                    ),
                    title: Container(
                        alignment: Alignment.centerLeft,
                        height: 35,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Text(
                              user.displayName!,
                              // _docdata!["B4namepro"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              user.email!,
                              // _docdata!["B4namepro"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ))),
                const Divider(thickness: 2, color: Colors.black),
                TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.multiline,
                  maxLength: 200,
                  maxLines: 5,
                  minLines: 1,
                  decoration: InputDecoration(
                    labelText: 'Write is comment...',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.keyboard),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {},
                          color: Colors.amber,
                          icon: const Icon(Icons.emoji_emotions_outlined),
                        ),
                        IconButton(
                          onPressed: () {},
                          color: Colors.red,
                          icon: const Icon(Icons.image),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          padding: const EdgeInsets.symmetric(horizontal: 16)),
                      onPressed: () {},
                      child: const Text('Post'),
                    ))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
