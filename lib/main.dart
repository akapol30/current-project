import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_towin/src/Login/Google/login_signin.dart';
import 'package:project_towin/src/bloc/bloc_signin_google/auth_bloc.dart';
import 'package:project_towin/src/manu/book/book_addfood_item.dart';
import 'src/Login/system/login_layout.dart';
import 'src/page/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(supportedLocales: const [
    Locale('th', 'TH'),
    Locale('en', 'US'),
    Locale('zh', 'CN'),
    Locale('zh', 'TW'),
  ], path: 'assets/translations', child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = const LoginGoogle();
  @override
  void initState() {
    super.initState();
    // authClass.signOut();
    checkLogin();
  }

  void checkLogin() async {
    if (FirebaseAuth.instance.currentUser != null) {
      setState(() {
        currentPage = const Home();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => AuthRepository(),
        child: BlocProvider(
            create: (context) => AuthBloc(
                  authRepository:
                      RepositoryProvider.of<AuthRepository>(context),
                ),
            child: MaterialApp(
                //routes: AppRoute().getAll,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.amber,
                ),
                home: currentPage)));
    /* MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(
                    authRepository:
                        RepositoryProvider.of<AuthRepository>(context),
                  ))
        ],
        child: MaterialApp(
            //routes: AppRoute().getAll,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.amber,
            ),
            home: currentPage));*/
    /*RepositoryProvider(
        create: (context) => AuthRepository(),
        child: BlocProvider(
            create: (context) => AuthBloc(
                  authRepository:
                      RepositoryProvider.of<AuthRepository>(context),
                ),
            child: MaterialApp(
                //routes: AppRoute().getAll,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.amber,
                ),
                home: currentPage))); */
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
