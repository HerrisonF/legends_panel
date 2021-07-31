import 'package:legends_panel/app/translations/en_US/en_us_translations.dart';
import 'package:legends_panel/app/translations/pt_BR/pt_br_translations.dart';

abstract class AppTranslation{

  static Map<String, Map<String, String>>
  translations = {
    'pt_BR' : ptBr,
    'en_US' : enUs
  };

}