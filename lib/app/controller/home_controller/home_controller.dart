import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:legends_panel/app/data/repository/home_repository.dart';

class HomeController extends MasterController {

  HomeRepository homeRepository = HomeRepository();

  getAlgo(){
    homeRepository.getAlgo();
  }

}