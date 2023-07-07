import 'package:flutter/material.dart';





class TranslationWidget extends StatefulWidget {
  const TranslationWidget({super.key});

  @override
  State<TranslationWidget> createState() => _TranslationWidgetState();
}

class _TranslationWidgetState extends State<TranslationWidget> {
  String? language;
  String? message;
  String? translation;
  @override
  Widget build(BuildContext context) {
    return Container(
    /*return FutureBuilder(
      future:
          TranslationApi.translateData(message!, getLanguageCode(language!)),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          translation = 'Could not translate due to Network problems';
        }else
          translation = snapshot.data;
          
      },*/
    );
  }

  static String getLanguageCode(String language) {
    switch (language) {
      case 'English':
        return 'en';
      case 'Thai':
        return 'th';
      case 'Chinese (Simplified)':
        return 'cn';
      case 'Chinese (Traditional)':
        return 'tw';
    }
    return language;
  }
}
