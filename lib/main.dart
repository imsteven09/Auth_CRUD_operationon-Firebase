import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:operationsonfirebase/firebase_options.dart';
import 'package:operationsonfirebase/ui/home_screen.dart';
//import 'package:operationsonfirebase/ui/home_screen.dart';
//import 'package:operationsonfirebase/ui/home_screen.dart';
//import 'package:operationsonfirebase/ui/postsignin.dart';
//import 'package:operationsonfirebase/ui/signin_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
