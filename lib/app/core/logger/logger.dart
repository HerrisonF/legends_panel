import 'package:legends_panel/app/core/error_base/failure.dart';

abstract class Logger {

  void logERROR(Failure failure);

  void logDEBUG(String message);

}