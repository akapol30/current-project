import 'dart:math';

import 'package:project_towin/src/modelclass/class_postmodel.dart';

import 'inheritedpostmodel.dart';

import 'package:like_button/like_button.dart';
import 'package:flutter/material.dart';

bool _isLandscape(BuildContext context) =>
    MediaQuery.of(context).orientation == Orientation.landscape;

class TravelPostCardNorth extends StatelessWidget {
  final PostModel postData;

  const TravelPostCardNorth({Key? key, required this.postData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color:
          Colors.primaries[Random().nextInt(Colors.primaries.length)].shade200,
      elevation: 2,
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(4.0),
        // I created it here!
        child: InheritedPostModel(
          postData: postData,
          child: Column(
            children: const <Widget>[
              _PostDetails(),
              Divider(thickness: 2, color: Colors.black),
              _Post(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Post extends StatelessWidget {
  const _Post({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostModel postData = InheritedPostModel.of(context).postData;

    return Row(children: <Widget>[
      _PostImage(postData.imageURL),
      const Expanded(child: _PostTitleSummaryAndTime()),
    ]);
  }
}

class _PostTitleSummaryAndTime extends StatelessWidget {
  const _PostTitleSummaryAndTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Getting data from inherited widget
    final PostModel postData = InheritedPostModel.of(context).postData;

    // using data retrieved from inherited widget
    final String title = postData.title;
    final String summary = postData.summary;

    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 2.0),
              Text(summary),
            ],
          ),
          _PostTimeStamp(postData.postTimeFormatted),
        ],
      ),
    );
  }
}

class _PostImage extends StatelessWidget {
  final String imageStr;
  const _PostImage(this.imageStr, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 100, child: Image.asset(imageStr));
  }
}

class _PostDetails extends StatelessWidget {
  const _PostDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostModel postData = InheritedPostModel.of(context).postData;

    int favoriteCount = 0;

    return Row(
      children: <Widget>[
        _UserImage(postData.author.image),
        _UserNameAndEmail(
          userName: postData.author.name,
          userEmail: postData.author.email,
        ),
        Expanded(
            child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(left: 130),
              child: LikeButton(
                size: 40,
                isLiked: false,
                likeCount: favoriteCount,
                likeCountPadding: const EdgeInsets.only(left: 10),
                countBuilder: (likeCount, isLiked, text) {
                  const color = Colors.black;
                  return Text(
                    text,
                    style: const TextStyle(
                      color: color,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              )),
        ])),
      ],
    );
  }
}

class _UserNameAndEmail extends StatelessWidget {
  final String userName;
  final String userEmail;
  const _UserNameAndEmail(
      {Key? key, required this.userName, required this.userEmail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(userName),
          const SizedBox(height: 2.0),
          Text(userEmail),
        ],
      ),
    );
  }
}

class _UserImage extends StatelessWidget {
  final String imageString;
  const _UserImage(this.imageString, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: ExactAssetImage(imageString),
    );
  }
}

class _PostTimeStamp extends StatelessWidget {
  final String time;
  const _PostTimeStamp(
    this.time, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.bottomRight, child: Text(time));
  }
}
