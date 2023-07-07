import 'package:flutter/material.dart';
import 'package:project_towin/src/modelclass/class_postmodel.dart';

class InheritedPostModel extends InheritedWidget {
  final PostModel postData;

  @override
  // ignore: overridden_fields
  final Widget child;

  const InheritedPostModel({
    Key? key,
    required this.postData,
    required this.child,
  }) : super(key: key, child: child);

  static InheritedPostModel of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<InheritedPostModel>()
        as InheritedPostModel);
  }

  @override
  bool updateShouldNotify(InheritedPostModel oldWidget) {
    return true;
  }
}
