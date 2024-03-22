import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:operationsonfirebase/core/constants/color_constant.dart';
import 'package:operationsonfirebase/core/constants/string_constant.dart';
import 'package:operationsonfirebase/core/constants/textstyle_constant.dart';
import 'package:operationsonfirebase/ui/signin_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKEY = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        automaticallyImplyLeading: false,
        title: const Text(
          StringConstant.signup,
          style: TextStyleConstant.signupappbar,
        ),
        backgroundColor: ColorConstants.signupAppBar,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Image.asset('assets/images/crudlogo.webp'),
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
                          _auth
                              .createUserWithEmailAndPassword(
                                  email: emailController.text.toString(),
                                  password: passwordController.text.toString())
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('signedup')));
                          }).onError((error, stackTrace) {
                            // Utils.toastmessage(error.toString());
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(error.toString())));
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        height: 40,
                        decoration: BoxDecoration(
                            color: ColorConstants.signup,
                            borderRadius: BorderRadius.circular(15)),
                        child: const Text(
                          StringConstant.signup,
                          style: TextStyleConstant.signup,
                        ),
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                const Text(
                  StringConstant.orsignupwith,
                  style: TextStyleConstant.orsignupwith,
                ),
                const SizedBox(
                  height: 10,
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
                                  'assets/images/facebooklogo.png'))),
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
                              fit: BoxFit.cover,
                              image:
                                  AssetImage('assets/images/twitterlogo.png'))),
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
                              fit: BoxFit.cover,
                              image:
                                  AssetImage('assets/images/googlelogo.png'))),
                      //child: Image.asset('assets/images.facebooklogo.png'),
                    )

                    // Image.asset('assets/images.googlelogo.png'),
                    // Image.asset('assets/images.twitterlogo.png'),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(StringConstant.alreadyhaveanaccount),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const SigninPage();
                    }));
                  },
                  child: const Text(
                    StringConstant.signin,
                    style: TextStyleConstant.signinpage,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
