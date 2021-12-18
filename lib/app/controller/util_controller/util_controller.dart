import 'package:flutter/cupertino.dart';

abstract class UtilController {

  static closeKeyBoard(BuildContext context){
    FocusScope.of(context).unfocus();
  }

}