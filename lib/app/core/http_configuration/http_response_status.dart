/// Essa classe apenas abstrai os números mágicos das requisições para melhorar
/// a leitura.
abstract class HttpResponseStatus {
  static const int SUCCESS = 200;
  static const int CREATED = 201;
  static const int UNAUTHORIZED = 401;
  static const int BAD_REQUEST = 400;
}