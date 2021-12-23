import 'package:legends_panel/app/data/provider/general_vision_provider/general_vision_provider.dart';

class GeneralVisionRepository{
  final GeneralVisionProvider _generalVisionProvider = GeneralVisionProvider();

  String getBaronIcon(){
    return _generalVisionProvider.getBaronIcon();
  }

  String getDragonIcon(){
    return _generalVisionProvider.getDragonIcon();
  }

  String getTowerIcon(){
    return _generalVisionProvider.getTowerIcon();
  }

  String getKillIcon(){
    return _generalVisionProvider.getKillIcon();
  }
}