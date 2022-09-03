import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/loginscreen.dart';

import 'products.dart';
import 'profile.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: ()async{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return ProfileScreen();}));

              },
              child: Text("ProfileScreen"),
            ),
            GestureDetector(
              onTap: ()async{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return ProductsScreen();}));

              },
              child: Text("products"),
            ),
            GestureDetector(
              onTap: ()async{
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return LoginScreen();}));

              },
              child: Text("log out"),
            ),
          ],
        ),
      ),
    );
  }
}
