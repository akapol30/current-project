import 'package:intl/intl.dart';
import 'package:project_towin/src/modelclass/class_usermodel.dart';

class PostModel {
  final String id, title, summary, body, imageURL;
  final DateTime postTime;
  final int reacts;
  final UserModel author;

  const PostModel({
    required this.id,
    required this.title,
    required this.summary,
    required this.body,
    required this.imageURL,
    required this.author,
    required this.postTime,
    required this.reacts,
  });

  String get postTimeFormatted => DateFormat.yMMMMEEEEd().format(postTime);
}
