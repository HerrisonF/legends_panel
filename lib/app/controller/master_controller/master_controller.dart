import 'package:get/get.dart';

class MasterController {

  RxInt currentPageIndex = 0.obs;

  changeCurrentPageIndex(int newPageIndex){
    currentPageIndex(newPageIndex);
  }

}