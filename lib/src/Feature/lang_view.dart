import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:project_towin/main.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 26),
              margin: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: const Text(
                'Choose language',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 18,
                ),
              ),
            ),
            _SwitchListTileMenuItem(
                title: 'English',
                subtitle: 'English',
                locale: context.supportedLocales[1]),
            const _Divider(),
            _SwitchListTileMenuItem(
                title: 'Thai',
                subtitle: 'Thai',
                locale: context.supportedLocales[0]),
            const _Divider(),
            _SwitchListTileMenuItem(
                title: 'Chinese (Simplified)',
                subtitle: 'Chinese (Simplified)',
                locale: context.supportedLocales[2]),
            const _Divider(),
            _SwitchListTileMenuItem(
                title: 'Chinese (Traditional)',
                subtitle: 'Chinese (Traditional)',
                locale: context.supportedLocales[3]),
            const _Divider()
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: const Divider(
        color: Colors.grey,
      ),
    );
  }
}

class _SwitchListTileMenuItem extends StatelessWidget {
  const _SwitchListTileMenuItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.locale,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Locale locale;

  bool isSelected(BuildContext context) => locale == context.locale;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
      decoration: BoxDecoration(
        border:
            isSelected(context) ? Border.all(color: Colors.blueAccent) : null,
      ),
      child: ListTile(
          dense: true,
          // isThreeLine: true,
          title: Text(
            title,
          ),
          subtitle: Text(
            subtitle,
          ),
          onTap: () async {
            log(locale.toString(), name: toString());
            await context.setLocale(locale);

            // ignore: use_build_context_synchronously
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const MyApp()));
          }),
    );
  }
}
