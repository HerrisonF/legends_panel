import 'package:dio/dio.dart';

/// Classe mãe de todos os erros.

class Failure implements Exception {

  /// As mensagens de detalhes, sempre serão de interesse do desenvolvedor.
  ///
  /// Caso precise fazer o detalhamento de mensagens conforme statusCode,
  /// tente fazer aqui nessa classe, para que valha à o app em geral.

  String? id;
  String message;
  String? error;
  int? status;

  Failure({
    this.id,
    this.message = "",
    this.error,
    this.status,
  });

  factory Failure.dioError(DioError dioError){
    return Failure(
      id: dioError.response != null ? dioError.response!.data["id"] : "",
      status: dioError.response != null ? dioError.response!.data["status"] : 0,
      message: dioError.response != null ? dioError.response!.data["message"] : "",
      error: dioError.response != null ? dioError.response!.data["error"] : "",
    );
  }

  String logFullError(){
    return "ID: ${id ?? ""} - STATUS: ${status ?? 0} - MESSAGE: $message - ERROR: ${error ?? ""}";
  }


}
