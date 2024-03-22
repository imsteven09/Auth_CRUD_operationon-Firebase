import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:operationsonfirebase/ui/postsignin.dart';
import 'package:operationsonfirebase/ui/signin_page.dart';

class SigninService {
  static void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(Duration(seconds: 1), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PostScreen();
        }));
      });
    } else {
      Timer(Duration(seconds: 1), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SigninPage();
        }));
      });
    }
  }
}
