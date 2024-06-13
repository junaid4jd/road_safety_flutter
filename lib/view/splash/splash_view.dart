import 'dart:async';

import 'package:flutter/material.dart';
import 'package:road_safety/res/colors.dart';
import 'package:road_safety/res/components/app_text.dart';
import 'package:road_safety/utils/services/splash_services.dart';
import 'package:road_safety/view/authentication/userType/usertype_screen.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final splashDelay = 3; // delay for 5 seconds

  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => UserType()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration:  BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/splash_img.jpeg"),
          fit: BoxFit.cover),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Container(
        //       child: Image.asset('assets/images/logo.png', height: 100,width: 100,fit: BoxFit.scaleDown,),
        //     ),
        //     Center(
        //         child: Padding(
        //           padding: EdgeInsets.only(top: 10),
        //           child: Text(
        //             'Road Safety',
        //             style: TextStyle(
        //                 fontSize: TextStylesData.headingSmallFontSize,
        //                 color: AppColors.blackColor,
        //                 fontWeight: FontWeight.bold),
        //             textAlign: TextAlign.center,
        //           ),
        //         )),
        //   ],
        // ),
      ),
      ) );
  }
}
