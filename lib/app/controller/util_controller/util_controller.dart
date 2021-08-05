import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

abstract class UtilController {

  GetStorage box = GetStorage('default_storage');

  closeKeyBoard(BuildContext context){
    FocusScope.of(context).unfocus();
  }

}