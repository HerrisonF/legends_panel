import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

abstract class UtilController {

  GetStorage box = GetStorage('default_storage');

  static closeKeyBoard(BuildContext context){
    FocusScope.of(context).unfocus();
  }

  String getConvertedTimeInMinutes(int time){
    int minutes = (time / 60).truncate();
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    return minutesStr;
  }

}