import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/splashscreen_controller/splashscreen_controller.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashscreenController _splashscreenController = Get.find<SplashscreenController>();

  @override
  void initState() {
    super.initState();
    _splashscreenController.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.7),
            ],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              child: Image(
                image: AssetImage(objRockTr),
                height: MediaQuery.of(context).size.height / 2,
              ),
              left: 0,
              top: 0,
            ),
            Positioned(
              child: Image(
                image: AssetImage(objRockTl),
                height: MediaQuery.of(context).size.height / 2,
              ),
              left: 0,
              bottom: 0,
            ),
            Center(
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.easeIn,
                child: Text(
                  "APP_NAME".tr,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.white,
                      shadows: [
                        BoxShadow(
                            color: Theme.of(context).primaryColor,
                            blurRadius: 2,
                            offset: Offset(0,2)
                        ),
                      ],
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
