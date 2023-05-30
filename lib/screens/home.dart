import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../common/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  // route to home screen
  static const String routeName = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await storage.deleteAll();
              Navigator.of(context).pushNamed(Constants.signInRoute);
            },
            icon: const Icon(Icons.login),
          ),
        ],
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
    ));
  }
}
