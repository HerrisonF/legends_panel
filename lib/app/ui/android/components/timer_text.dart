import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';

class TimerText extends StatefulWidget {
  final int time;

  const TimerText({Key? key, required this.time}) : super(key: key);

  @override
  _TimerTextState createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText> {

  final MasterController _masterController = Get.find<MasterController>();

  late Timer _timer;
  int seconds = 0;
  int min = 0;

  void startTimer() {
    seconds = getConvertedTimeInMinutes(widget.time);
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if(seconds == 59){
          setMoreOneMinute();
        }
        setState(() {
          seconds++;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    seconds = 0;
    min = 0;
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "${min<10? "0" : ""}$min : ${seconds<10? "0" : ""}$seconds",
      style: GoogleFonts.aBeeZee(
        fontSize: _masterController.screenSizeIsBiggerThanNexusOne() ? 15 : 11,
        color: Colors.white,
        letterSpacing: 0.5,
      ),
    );
  }

  getConvertedTimeInMinutes(int time){
    min = (time / 60).truncate();
    if(min==0){
      return time;
    }
    return (min % 60);
  }

  setMoreOneMinute(){
    setState(() {
      min++;
      seconds = 0;
    });
  }

}
