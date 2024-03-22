import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:operationsonfirebase/core/constants/color_constant.dart';
import 'package:operationsonfirebase/core/constants/string_constant.dart';
import 'package:operationsonfirebase/core/constants/textstyle_constant.dart';

import 'package:operationsonfirebase/ui/postsignin.dart';
import 'package:operationsonfirebase/ui/signup_page.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool loading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKEY = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        title: const Text(
          StringConstant.signin,
          style: TextStyleConstant.signinappbar,
        ),
        centerTitle: true,
        backgroundColor: ColorConstants.signinAppBar,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/crudlogo.webp',
            ),
            const Text(
              StringConstant.logintoyouraccnt,
              style: TextStyleConstant.logintoyouraccnt,
            ),
            Form(
                key: _formKEY,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          hintText: StringConstant.email),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      obscureText: true,
                      obscuringCharacter: '*',
                      controller: passwordController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          hintText: StringConstant.password),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        if (_formKEY.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          _auth
                              .signInWithEmailAndPassword(
                                  email: emailController.text.toString(),
                                  password: passwordController.text.toString())
                              .then((value) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const PostScreen();
                            }));
                          }).onError((error, stackTrace) {
                            setState(() {
                              loading = false;
                            });
                            // Utils.toastmessage(error.toString());
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(error.toString())));
                          });
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 40,
                        decoration: BoxDecoration(
                            color: ColorConstants.signin,
                            borderRadius: BorderRadius.circular(15)),
                        child: const Text(
                          StringConstant.signin,
                          style: TextStyleConstant.signin,
                        ),
                      ),
                    ),
                  ],
                )),
            Column(
              children: [
                const Text(
                  StringConstant.orsigninwith,
                  style: TextStyleConstant.orsigninwith,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/images/facebooklogo.png',
                              ))),
                      //child: Image.asset('assets/images.facebooklogo.png'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),

                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image:
                                  AssetImage('assets/images/twitterlogo.png'))),
                      //child: Image.asset('assets/images.facebooklogo.png'),
                    ),

                    // Image.asset('assets/images.googlelogo.png'),
                    // Image.asset('assets/images.twitterlogo.png'),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: () {
                try {
                  GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
                  _auth.signInWithProvider(_googleAuthProvider).then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const PostScreen();
                    })).onError((error, stackTrace) =>
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('sorry'))));
                  });
                } catch (error) {
                  print(error);
                }
                setState(() {
                  Timer(const Duration(seconds: 5), () {});
                });
              },
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      //color: ColorConstants.signinwithgoogle,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                          width: 2,
                          color: ColorConstants.signinwithgoogleborder)),
                  height: 58,
                  width: 311,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/googlelogo.png',
                        height: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        StringConstant.signinwithgoogle,
                        style: TextStyleConstant.signinwithgoogletext,
                      ),
                    ],
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(StringConstant.donthaveaccnt),
                InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const SignupPage();
                      }));
                    },
                    child: const Text(
                      StringConstant.signup,
                      style: TextStyleConstant.signuppage,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
