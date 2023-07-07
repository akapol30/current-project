import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:project_towin/src/bloc/bloc_signin_google/auth_bloc.dart';
import 'package:project_towin/src/page/homepage.dart';
import 'package:provider/provider.dart';

class LoginGoogle extends StatefulWidget {
  const LoginGoogle({super.key});

  @override
  State<LoginGoogle> createState() => _LoginGoogleState();
}

class _LoginGoogleState extends State<LoginGoogle> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber.shade200,
        body: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.asset("assets/images/Towin.png"),
              ),
              const SizedBox(height: 10),
              const Text("It's more than you think",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PinyonScript')),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  child: Row(
                    children: [
                      Image.asset('assets/images/googlebutton.png'),
                      const Text(
                        'Sign In With Google',
                        style: TextStyle(fontSize: 25, fontFamily: 'Mitr'),
                      )
                    ],
                  ),
                  onPressed: () {
                    // your implementation
                    setState(() {
                      isLoading = !isLoading;
                    });
                    context.read<AuthBloc>().add(GoogleSignInRequested());
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => const Home()));
                  },
                ),
              ),
              /*child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 50)),
                      icon: const FaIcon(FontAwesomeIcons.google,
                          color: Colors.red),
                      label: const Text(
                        "Sign Up With Google",
                        style: TextStyle(fontFamily: 'Mitr'),
                      ),
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin().then((value) {
                          if (FirebaseAuth.instance.currentUser != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Towin()));
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LoginGoogle()));
                          }
                        });
                      })),*/
              /*Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20,bottom: 20),
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 50)),
                      icon: const FaIcon(FontAwesomeIcons.apple,
                          color: Colors.white),
                      label: const Text("Sign Up With Apple ID"),
                      onPressed: () {
                       
                      })),
                      Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20,bottom: 20),
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 50)),
                      icon: const FaIcon(FontAwesomeIcons.facebook,
                          color: Colors.blue),
                      label: const Text("Sign Up With Facebook"),
                      onPressed: () {
                        signInWithFacebook(context).then((value) {
                       if (FirebaseAuth.instance.currentUser != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => const Towin(
                                      title: "contry",
                                    )));
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LoginGoogle()));
                          }
                      });
                      }))*/
            ])));
  }
}
