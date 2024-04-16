import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:numeron/ui/home/screen.dart';
import 'package:numeron/utils/initialize_wrapper.dart';

class GoogleSignin extends StatelessWidget {
  const GoogleSignin({super.key});

  initialize(context) {
    if (FirebaseAuth.instance.currentUser != null) {
      debugPrint('Already signed in');

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const HomeScreen(
                    title: 'Numer0n',
                  )));
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return InitializeWrapper(
        onInit: () {
          initialize(context);
        },
        child: Scaffold(
          body: Center(
            child: Container(
                alignment: Alignment.center,
                width: 250,
                height: 150,
                child: ElevatedButton(
                  onPressed: () async {
                    await signInWithGoogle();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomeScreen(
                              title: 'Numer0n',
                            )));
                  },
                  child: const Text('Google'),
                )),
          ),
        ));
  }
}
