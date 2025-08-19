import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/core/constants/image_strings.dart';
import 'package:news_app/core/route/route_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    super.initState();
    Timer( Duration(seconds: 2),
            (){
    Navigator.pushReplacementNamed(context, RouteNames.home);
    });
    }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: Center(child: Image(image: AssetImage(TImages.lightapplogo))),
floatingActionButton: Container(
  width: 200,
    child: Image(image: AssetImage(TImages.lightrootlogo),fit: BoxFit.cover,)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}
