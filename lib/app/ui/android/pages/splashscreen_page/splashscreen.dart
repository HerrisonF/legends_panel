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

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  SplashscreenController _splashscreenController =
      Get.put(SplashscreenController());

  late AnimationController _controller;

  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.repeat(reverse: true);
    _splashscreenController.start();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static const int NEXUS_ONE_SCREEN = 800;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0.1),
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter),
        ),
        child: Stack(
          children: [
            Positioned(
              child: Image(
                image: AssetImage(imageRockTopRight),
                height: MediaQuery.of(context).size.height / 2.5,
              ),
              left: 0,
              top: 0,
            ),
            Positioned(
              child: Image(
                image: AssetImage(imageRockTopRight),
                height: MediaQuery.of(context).size.height / 2.5,
              ),
              left: MediaQuery.of(context).size.width / 2,
              top: 150,
            ),
            Positioned(
              child: Image(
                image: AssetImage(imageRockTopLeft),
                height: MediaQuery.of(context).size.height / 2.5,
              ),
              left: MediaQuery.of(context).size.width / 1.5,
              top: -150,
            ),
            Positioned(
              child: Image(
                image: AssetImage(imageRockTopLeft),
                height: MediaQuery.of(context).size.height / 2.2,
              ),
              left: 0,
              bottom: 0,
            ),
            Positioned(
              child: Image(
                image: AssetImage(imageRockTopLeft),
                height: MediaQuery.of(context).size.height / 2.2,
              ),
              left: MediaQuery.of(context).size.width / 2,
              bottom: MediaQuery.of(context).size.width / 2,
            ),
            Positioned(
              child: Image(
                image: AssetImage(imagePengu),
                height: MediaQuery.of(context).size.height / 2.5,
              ),
              right: 0,
              bottom: 0,
            ),
            _title(context),
            _subTitle(context),
          ],
        ),
      ),
    );
  }

  Widget _subTitle(BuildContext context) {
    return _textSplashscreenMaker(
      "APP_NAME_SUB_TITLE".tr,
      MediaQuery.of(context).size.height / 2.1,
    );
  }

  Widget _title(BuildContext context) {
    return _textSplashscreenMaker(
        "APP_NAME_TITLE".tr, MediaQuery.of(context).size.height / 2.5);
  }

  Widget _textSplashscreenMaker(String text, double margin) {
    return Container(
      margin: EdgeInsets.only(top: margin),
      alignment: Alignment.topCenter,
      child: FadeTransition(
        opacity: _animation,
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              color: Colors.white,
              shadows: [
                BoxShadow(
                    color: Colors.black, blurRadius: 16, offset: Offset(0, 2)),
              ],
              fontSize: MediaQuery.of(context).size.height > NEXUS_ONE_SCREEN
                  ? 40 : 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
